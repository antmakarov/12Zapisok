//
//  DetailNoteViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol DetailNoteViewModeling {
    var id: Int { get }
    var title: String { get }
    var imgUrl: String { get }
    var isOpen: Bool { get }
}

class DetailNoteViewModel {
    
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
}

extension DetailNoteViewModel: DetailNoteViewModeling {
    var title: String {
        return note.name
    }
    
    var imgUrl: String {
        return ""
    }
    
    var isOpen: Bool {
        return .random()
    }
    
    public var id: Int {
        return note.id
    }
}
