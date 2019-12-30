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

    private var dataUpdateHandler: (() -> Void)?
    var dataFetcher: NotesFetchProtocol!
    var city: City?
    
    private var selectedIndexPath: IndexPath?
    
    init(typeFetcher: TypeFetcher = .network) {
        
        switch typeFetcher {
        case .network:
            dataFetcher = NetworkManager()
            
        case .storage:
            dataFetcher = NetworkManager()
        }
    }
    
    //  MARK: CollectionViewGameViewModel
    
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
        return city?.name ?? ""
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
