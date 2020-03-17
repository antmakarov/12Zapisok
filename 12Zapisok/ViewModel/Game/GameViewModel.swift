//
//  GameViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol GameViewModeling {
    func cityName() -> String
    func noteCell(at index: Int) -> NoteCollectionCellViewModel
    func noteDetails(at index: Int) -> DetailNoteViewModeling
    func numberOfNotes() -> Int
    func setUpdateHandler(_ handler: (() -> Void)?)
}

class GameViewModel {

    weak var coordinatorDelegate: GameViewModelCoordinatorDelegate?

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    private var currentCityName: String?
    private var gameNotes = [Note]()
    private var dataUpdateHandler: (() -> Void)?
    
    convenience init(cityName: String?) {
        self.init(cityName: cityName, preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(cityName: String?, typeFetcher: TypeFetcher = .network, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        currentCityName = cityName
        loadNotes()
    }
        
    private func loadNotes() {
        guard let cityID = preferencesManager.currentCityId else {
            Logger.error(msg: "Unable to get id of current city")
            return
        }
    
        networkManager.getNoteList(parameters: ["town_id": cityID]) { [weak self] result in
            switch result {
            case .success(let notes):
                self?.gameNotes = notes
                self?.dataUpdateHandler?()
            
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
    }
}

extension GameViewModel: GameViewModeling {
    public func cityName() -> String {
        return currentCityName ?? .empty
    }

    public func noteCell(at index: Int) -> NoteCollectionCellViewModel {
        return NoteCollectionCellViewModel(note: gameNotes[index])
    }
    
    public func noteDetails(at index: Int) -> DetailNoteViewModeling {
        return DetailNoteViewModel(note: gameNotes[index])
    }
    
    public func numberOfNotes() -> Int {
        return gameNotes.count
    }
    
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        dataUpdateHandler = handler
    }
}
