//
//  GameNoteViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import CoreLocation

enum NoteState {
    case open
    case progress
    case close
}

protocol GameNoteViewModeling {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var imgUrl: String { get }
    var state: NoteState { get }
    var address: String { get }
    var openTime: String { get }
    var location: Location? { get }
    var routeTo: ((GameRouter) -> Void)? { get set }
    
    func completeNote(completion: @escaping (((Result<Bool, Error>)) -> Void))
    func getCountOfHints(type: HintType) -> Int
    func getDistanceStatus() -> String
}

final class GameNoteViewModel {
    
    private let note: Note
    public var routeTo: ((GameRouter) -> Void)?
    
    private var networkManager: NetworkManaging
    private var locationManager: LocationManaging
    private var hintManager: HintManaging
    private var dataUpdater: Observable<Int>
    
    convenience init(note: Note, observer: Observable<Int>) {
        self.init(note: note,
                  observer: observer,
                  networkManager: NetworkManager.shared,
                  locationManager: LocationManager.shared,
                  hintManager: HintManager.shared)
    }
    
    init(note: Note,
         observer: Observable<Int>,
         networkManager: NetworkManaging,
         locationManager: LocationManaging,
         hintManager: HintManaging) {
        self.note = note
        self.dataUpdater = observer
        self.networkManager = networkManager
        self.locationManager = locationManager
        self.hintManager = hintManager
    }
    
    private func checkPosition(location: Location?) -> Bool {
        if let location = location {
            return locationManager.closeToCoordinate(location.cll(), with: .average)
        }
        
        return false
    }
}

extension GameNoteViewModel: GameNoteViewModeling {
    func completeNote(completion: @escaping (((Result<Bool, Error>)) -> Void)) {
        if let location = note.location,
           locationManager.closeToCoordinate(location.cll(), with: .average) {
            networkManager.completeNote(id: note.id, completion: completion)
            dataUpdater.value = note.id
        } else {
            completion(.success(false))
        }
    }
    
    func getCountOfHints(type: HintType) -> Int {
        return hintManager.getCountOf(hint: type)
    }
    
    func getDistanceStatus() -> String {
        if let location = note.location {
            return Remoteness(distance: locationManager.distanceFromPoint(location.cll())).closestStatus()
        }
        return .empty
    }
    
    var title: String {
        return note.name
    }
    
    var description: String {
        return note.noteDescription
    }
    
    var imgUrl: String {
        return note.imageUrl
    }
    
    var location: Location? {
        return note.location
    }
    
    var state: NoteState {
        guard let statistics = note.statistics else {
            return .close
        }
        
        return statistics.isComplete ? .open : .progress
    }
    
    var address: String {
        return "ул. Максима Горького, 43" //TODO: Add real address
    }
    
    var openTime: String {
        return "вчера в 21:42" //TODO: Add real time
    }
    
    var id: String {
        return String(note.id)
    }
}
