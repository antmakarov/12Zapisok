//
//  CollectionViewGameViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CollectionViewGameViewModel {
    func numberOfCards() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionGameCellViewModel?
    
    func viewModelForSelectedNote() -> DetailNoteViewModelProtocol?
    func selectNote(atIndexPath indexPath: IndexPath)
}
