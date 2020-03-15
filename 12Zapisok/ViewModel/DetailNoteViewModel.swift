//
//  DetailNoteViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

class DetailNoteViewModel: DetailNoteViewModelProtocol {
    
    internal var note: Note
    
    init(note: Note) {
        self.note = note
    }
}
