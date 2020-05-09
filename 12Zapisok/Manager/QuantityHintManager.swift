//
//  QuantityHintManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

class QuantityHintManager {
    
    let preferencesManager = PreferencesManager.shared
    
    var isAvailableEnterAddress: Bool {
        get {
            return preferencesManager.isSuccessAuth
        }
        set {
            //a.isSuccessAuth = newValue
        }
    }
}
