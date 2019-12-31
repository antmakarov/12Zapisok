//
//  CityListViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CityListViewModelProtocol: CurrentCityProtocol {
    func getNumberOfCities() -> Int
    func cityAt(index: Int) -> City
    func setUpdateHandler(_ handler: (() -> Void)?)
    func saveCurrentCuty(city: City)
}

class CityListViewModel {
    
    private var cities = [City]()
    private var updateHandler: (() -> Void)?

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManagerProtocol
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManagerProtocol) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        fetchCities()
    }

    private func fetchCities() {
        
        if let cities = databaseStorage.getObjects(City.self) {
            self.cities = cities
            return
        }
        
        networkManager.getCityList { result in
            switch result {
            case .success(let cities):
                self.cities = cities
                self.cities.forEach { try! self.databaseStorage.storeObject($0) }
                self.updateHandler?()
                
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
         }
    }
}

extension CityListViewModel: CityListViewModelProtocol {
    func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    func getNumberOfCities() -> Int {
        return cities.count
    }
    
    func cityAt(index: Int) -> City {
        return cities[index]
    }
    
    func saveCurrentCuty(city: City) {
        preferencesManager.currentCityId = city.id
    }
    
    func getCurrentCityName() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.name ?? ""
    }
    
    func getCurrentImage() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.imageUrl ?? ""
    }
}
