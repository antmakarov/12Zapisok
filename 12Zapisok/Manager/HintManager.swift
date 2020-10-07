//
//  HintManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

enum Operation {
    case add
    case remove
}

enum HintType {
    case openSingleNote
    case singleNoteDistance
    case foreverDistance
    case showPlaceOnMap
    case foreverCoordinates
}

protocol HintManaging {
    func getCountOf(hint: HintType) -> Int
}

class HintManager {
    
    public static let shared = HintManager()
    
    var availableHints: [HintType: Int] = [.openSingleNote: 1]
    var totalHints: Int {
        availableHints.count
    }
    
    func updateHints(type: HintType, operation: Operation) {
        switch operation {
        case .add:
            availableHints[type]? += 1
            
        case .remove:
            availableHints[type]? -= 1
            if availableHints[type] == 0 {
                availableHints[type] = nil
            }
        }
    }
    
    func getCountOf(hint: HintType) -> Int {
        return availableHints[hint] ?? 0
    }
    
    
}

extension HintManager: HintManaging {

}
