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
    func note(at index: Int) -> NoteCollectionCellViewModel?
    func numberOfNotes() -> Int
    func setUpdateHandler(_ handler: (() -> Void)?)
}

class GameViewModel {

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    private var currentCity: City?
    private var noteViewModels = [NoteCollectionCellViewModel]()
    private var dataUpdateHandler: (() -> Void)?
    private var selectedIndexPath: IndexPath?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(typeFetcher: TypeFetcher = .network, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
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
                self?.noteViewModels = notes.map { NoteCollectionCellViewModel(note: $0) }
                self?.dataUpdateHandler?()
            
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
    }
    
    func cellViewModel(for selectedNote: IndexPath) -> NoteCollectionCellViewModel? {
        //let note = city?.notes[indexPath.row]
        return nil //GameCellViewModel(note: note!)
    }
    
    func viewModelForSelectedNote() -> DetailNoteViewModeling? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return nil //DetailViewModel(note: city!.notes[selectedIndexPath.row])
    }
    
    func selectNote(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}

extension GameViewModel: GameViewModeling {
    public func cityName() -> String {
        return currentCity?.name ?? ""
    }

    public func note(at index: Int) -> NoteCollectionCellViewModel? {
        return noteViewModels[index]
    }
    
    public func numberOfNotes() -> Int {
        return noteViewModels.count
    }
    
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        dataUpdateHandler = handler
    }
}
