//
//  HintManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

enum Operation {
    case add
    case remove
}

enum HintType: String {
    case openSingleNote
    case singleNoteDistance
    case foreverDistance
    case showPlaceOnMap
    case foreverCoordinates
}

protocol HintManaging {
    func getCountOf(hint: HintType) -> Int
    func availableHintFor(note: Int, with type: HintType) -> Bool
    func updateHint(type: HintType, operation: Operation, for note: Int)
    func updateHint(type: HintType, operation: Operation)
}

final class HintManager {
    
    public static let shared = HintManager()
    
    private let preferencesManager: PreferencesManager

    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared)
    }
    
    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
        availableHints = preferencesManager.myCurrentHints
        hintNotes = preferencesManager.hintsForNote
    }
    
    var hintNotes: [String: [HintType]] = [:] {
        didSet {
            preferencesManager.hintsForNote = hintNotes
        }
    }
    
    var availableHints: [String: Int] = [:] {
        didSet {
            preferencesManager.myCurrentHints = availableHints
        }
    }
    
    var totalHints: Int {
        availableHints.count
    }
    
    func availableHintFor(note: Int, with type: HintType) -> Bool {
        return hintNotes[String(note)]?.contains(type) ?? false
    }
    
    func updateHint(type: HintType, operation: Operation, for note: Int) {
        if type == .showPlaceOnMap ||
            type == .singleNoteDistance ||
            type == .foreverCoordinates {
            var curHints = hintNotes[String(note)] ?? []
            curHints.append(type)
            hintNotes[String(note)] = [type]
        }
        updateHint(type: type, operation: operation)
    }
    
    func updateHint(type: HintType, operation: Operation) {
        let typeValue = type.rawValue
        
        switch operation {
        case .add:
            var curScore = availableHints[typeValue] ?? 0
            curScore += 1
            availableHints[typeValue] = curScore
            
        case .remove:
            availableHints[typeValue]? -= 1
            if availableHints[typeValue] == 0 {
                availableHints[typeValue] = nil
            }
        }
    }
    
    func getCountOf(hint: HintType) -> Int {
        return availableHints[hint.rawValue] ?? 0
    }
}

extension HintManager: HintManaging {

}
