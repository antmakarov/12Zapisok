//
//  NoteCollectionCellViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol NoteCollectionCellViewModeling {
    var id: Int { get }
    var title: String { get }
    var imgUrl: String { get }
    var isOpen: Bool { get }
}

class NoteCollectionCellViewModel: NoteCollectionCellViewModeling {
   
    var id: Int
    var title: String
    var imgUrl: String
    var isOpen: Bool
    
    init(note: Note) {
        id = note.id
        title = note.name
        imgUrl = ""
        isOpen = .random() // note.statistics?.isOpen ?? false
    }
}

