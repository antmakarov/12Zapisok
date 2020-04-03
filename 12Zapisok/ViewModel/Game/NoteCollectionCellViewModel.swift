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
    var state: NoteState { get }
}

class NoteCollectionCellViewModel: NoteCollectionCellViewModeling {
   
    var id: Int
    var title: String
    var imgUrl: String
    var state: NoteState
    
    init(note: Note) {
        id = note.id
        title = note.name
        imgUrl = note.imageUrl
        
        if let statistics = note.statistics {
            state = statistics.isComplete ? .open : .progress
        } else {
            state = .close
        }
    }
}

