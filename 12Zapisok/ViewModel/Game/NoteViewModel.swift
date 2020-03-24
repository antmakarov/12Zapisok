//
//  GameNoteViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol GameNoteViewModeling {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var imgUrl: String { get }
    var isOpen: Bool { get }
    var routeTo: ((GameRouter) -> Void)? { get set }
    
    func openNote(completion: @escaping ((Bool) -> Void))
}

class GameNoteViewModel {
    
    private let note: Note
    public var routeTo: ((GameRouter) -> Void)?
    
    private var networkManager: NetworkManaging
    
    convenience init(note: Note) {
        self.init(note: note, networkManager: NetworkManager.shared)
    }
    
    init(note: Note, networkManager: NetworkManaging) {
        self.note = note
        self.networkManager = networkManager
    }
}

extension GameNoteViewModel: GameNoteViewModeling {
    func openNote(completion: @escaping ((Bool) -> Void)) {
        networkManager.openNote(id: note.id) { result in
            completion(result)
        }
    }
    
    var title: String {
        return note.name
    }
    
    var description: String {
        return note.description
    }
    
    var imgUrl: String {
        return note.imageUrl
    }
    
    var isOpen: Bool {
        return note.statistics?.isOpen ?? false
    }
    
    public var id: Int {
        return note.id
    }
}
