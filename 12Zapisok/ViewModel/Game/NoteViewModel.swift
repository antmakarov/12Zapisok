//
//  GameNoteViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import CoreLocation

enum NoteState {
    case open
    case progress
    case close
}

protocol GameNoteViewModeling {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var imgUrl: String { get }
    var state: NoteState { get }
    var location: Location? { get }
    var routeTo: ((GameRouter) -> Void)? { get set }
    
    func openNote(completion: @escaping ((Bool) -> Void))
}

class GameNoteViewModel {
    
    private let note: Note
    public var routeTo: ((GameRouter) -> Void)?
    
    private var networkManager: NetworkManaging
    private var locationManager: LocationManaging
    
    convenience init(note: Note) {
        self.init(note: note, networkManager: NetworkManager.shared, locationManager: LocationManager.shared)
    }
    
    init(note: Note, networkManager: NetworkManaging, locationManager: LocationManaging) {
        self.note = note
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    private func checkPosition(location: Location?) -> Bool {
        if let location = location {
            let distance = locationManager.distanceFromCoordinates(location.lat, location.lon)
            return distance < 100
        }
        
        return false
    }
}

extension GameNoteViewModel: GameNoteViewModeling {
    func openNote(completion: @escaping ((Bool) -> Void)) {
        if checkPosition(location: note.location) {
            networkManager.openNote(id: note.id) { result in
                completion(result)
            }
        } else {
            completion(false)
        }
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
    
    public var id: Int {
        return note.id
    }
}
