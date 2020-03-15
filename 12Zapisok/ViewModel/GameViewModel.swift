//
//  GameViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

enum TypeFetcher {
    case network
    case storage
}

protocol GameViewModelProtocol {
    func nameCity() -> String
    func noteAt(index: Int) -> DetailNoteViewModelProtocol?
    func setUpdateHandler(_ handler: (() -> Void)?)
}

class GameViewModel: CollectionViewGameViewModel {

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManagerProtocol
    private var currentCity: City?
    private var noteViewModels = [DetailNoteViewModelProtocol]()
    private var dataUpdateHandler: (() -> Void)?
    
    private var selectedIndexPath: IndexPath?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(typeFetcher: TypeFetcher = .network, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManagerProtocol) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        
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
                notes.forEach {
                    self?.noteViewModels.append(DetailNoteViewModel(note: $0))
                }
                self?.dataUpdateHandler?()
            
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
    }
    
    func numberOfCards() -> Int {
        return noteViewModels.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionGameCellViewModel? {
        //let note = city?.notes[indexPath.row]
        return nil //GameCellViewModel(note: note!)
    }
    
    func viewModelForSelectedNote() -> DetailNoteViewModelProtocol? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return nil //DetailViewModel(note: city!.notes[selectedIndexPath.row])
    }
    
    func selectNote(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}

extension GameViewModel: GameViewModelProtocol {
    func nameCity() -> String {
        return currentCity?.name ?? ""
    }

    func noteAt(index: Int) -> DetailNoteViewModelProtocol? {
        return noteViewModels[index]
    }
    
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        dataUpdateHandler = handler
    }
}
