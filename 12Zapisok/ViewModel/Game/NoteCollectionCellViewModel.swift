//
//  NoteCollectionCellViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

protocol NoteCollectionCellViewModeling {
    var id: Int { get }
    var title: String { get }
    var imgUrl: String { get }
    var openTime: String? { get }
    var state: NoteState { get }
}

final class NoteCollectionCellViewModel: NoteCollectionCellViewModeling {
   
    var id: Int
    var title: String
    var imgUrl: String
    var openTime: String?
    var state: NoteState
    
    init(note: Note) {
        id = note.id
        title = note.name
        imgUrl = note.imageUrl

        if let statistics = note.statistics {
            if statistics.isCompleted {
                openTime = "Открыта сегодня в 11:45" //TODO: Replace to real data
                state = .open
            } else {
                state = .progress
            }
        } else {
            state = .close
        }
        state = .close
    }
}
