//
//  PreferencesManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable foundation_using

import Foundation

final class PreferencesManager {

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
        get {
            return userDefaults.string(forKey: generateKey(#function))
        }
        set {
            Logger.info(msg: "Set new user token - \(newValue ?? .empty)")
            userDefaults.set(newValue, forKey: generateKey(#function))
            userDefaults.synchronize()
        }
    }
    
    // swiftlint:disable force_unwrapping
    var currentCityId: Int? {
        get {
            return userDefaults.integer(forKey: generateKey(#function))
        }
        set {
            Logger.info(msg: "Set new city - id \(newValue!)")
            updateCityIdHandler?(newValue!)
            userDefaults.set(newValue, forKey: generateKey(#function))
            userDefaults.synchronize()
        }
    }

    var myCurrentHints: [String: Int] {
        get {
            return userDefaults.dictionary(forKey: generateKey(#function)) as? [String: Int] ?? [:]
        }
        set {
            Logger.info(msg: "Set current user hints - \(myCurrentHints)")
            userDefaults.set(newValue, forKey: generateKey(#function))
        }
    }
    
    private func generateKey(_ key: String) -> String {
        return (Constants.appName ?? "12Zapisok") + "-" + key
    }
}
