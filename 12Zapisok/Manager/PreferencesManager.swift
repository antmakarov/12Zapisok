//
//  PreferencesManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

class PreferencesManager {

    private enum Constants {
        static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    static let shared = PreferencesManager()

    private let userDefaults: UserDefaults
    public var updateCityIdHandler: ((Int) -> Void)?

    init() {
        userDefaults = UserDefaults.standard
    }
    
    var isSuccessAuth: Bool {
        return userToken != nil && currentCityId != 0
    }
    
    var userToken: String? {
        set {
            Logger.info(msg: "Set new user token - \(newValue ?? .empty)")
            userDefaults.set(newValue, forKey: generateKey(#function))
            userDefaults.synchronize()
        }
        get { return userDefaults.string(forKey: generateKey(#function)) }
    }
    
    var currentCityId: Int? {
        set {
            Logger.info(msg: "Set new city - id \(newValue!)")
            updateCityIdHandler?(newValue!)
            userDefaults.set(newValue, forKey: generateKey(#function))
            userDefaults.synchronize()
        }
        
        get { return userDefaults.integer(forKey: generateKey(#function)) }
    }

    var myCurrentHints: [String: Int] {
        set {
            Logger.info(msg: "Set current user hints - \(myCurrentHints)")
            userDefaults.set(newValue, forKey:  generateKey(#function))
        }
        get {
            return userDefaults.dictionary(forKey: generateKey(#function)) as? [String: Int] ?? [:]
        }
    }
    
    private func generateKey(_ key: String) -> String {
        return (Constants.appName ?? "12Zapisok") + "-" + key
    }
}
