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
    func openNotes() -> Int
    func noteAt(index: Int) -> DetailViewModel?
    func setDataUpdateHandler(_ handler: (() -> Void)?)
}

class GameViewModel: CollectionViewGameViewModel {

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManagerProtocol
    private var currentCity: City?
    
    private var dataUpdateHandler: (() -> Void)?
    
    private var selectedIndexPath: IndexPath?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(typeFetcher: TypeFetcher = .network, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManagerProtocol) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
    }
    
    //  MARK: CollectionViewGameViewModel
    
    private func loadNotes() {
        networkManager.getNoteList { result in
            switch result {
            case .success(let notes):
                Logger.debug(msg: notes)
            
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
        networkManager.getNoteList { notes in
        
        }
    }
    func numberOfCards() -> Int {
        return 0 //city?.notes.count ?? 0
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
    
    func openNotes() -> Int {
        return 0 //city?.notes.filter { $0.isOpen }.count ?? 0
    }
    
    func noteAt(index: Int) -> DetailViewModel? {
        return  nil // city?.notes[index]
    }
    
    public func setDataUpdateHandler(_ handler: (() -> Void)?) {
        dataUpdateHandler = handler
        //refresh()
    }
}
