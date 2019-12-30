//
//  MenuViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol MenuViewModelProtocol {
    func getCityName() -> String
    func getCityImage() -> String
    func getCurrentCityScore() -> Int
}

class MenuViewModel {

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManager
    private var currentCity: City?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManager) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        getUserToken()
    }
    
    private func loadCurrentCity() {
        if let cityID = preferencesManager.currentCityId {
            currentCity = databaseStorage.getObjectByID(City.self, id: cityID)
        }
    }
    
    private func getUserToken() {
        if preferencesManager.userToken == nil {
            networkManager.getUserToken { [weak self] token in
                self?.preferencesManager.userToken = token
            }
        }
    }
}

extension MenuViewModel: MenuViewModelProtocol {
    func getCityName() -> String {
        return currentCity?.name ?? ""
    }
    
    func getCityImage() -> String {
        return currentCity?.imageUrl ?? ""
    }
    
    func getCurrentCityScore() -> Int {
        return 5
    }
}
