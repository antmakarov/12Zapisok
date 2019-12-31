//
//  MenuViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CurrentCityProtocol {
    func getCurrentCityName() -> String
    func getCurrentImage() -> String
}

protocol MenuViewModelProtocol: CurrentCityProtocol {
    func getCurrentCityScore() -> Int
}

class MenuViewModel {

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManagerProtocol
    private var currentCity: City?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManagerProtocol) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        loadCurrentCity()
        getUserToken()
        
        preferencesManager.updateCityIdHandler = { [weak self] id in
            self?.currentCity = self?.databaseStorage.getObjectByID(City.self, id: id)
        }
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
    func getCurrentCityName() -> String {
        return currentCity?.name ?? ""
    }
    
    func getCurrentImage() -> String {
        return currentCity?.imageUrl ?? ""
    }
    
    func getCurrentCityScore() -> Int {
        return 5
    }
}
