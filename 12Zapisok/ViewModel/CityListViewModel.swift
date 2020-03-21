//
//  CityListViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CityListViewModeling: CurrentCityProtocol {
    func getNumberOfCities() -> Int
    func cityAt(index: Int) -> City
    func setUpdateHandler(_ handler: (() -> Void)?)
    func saveCurrentCity(at index: Int)
    
    var isOnboarding: Bool { get }
    var closeButtonPressed: (() -> Void)? { get set }
}

class CityListViewModel {
    
    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    private var cities = [City]()
    private var updateHandler: (() -> Void)?
    
    public var isOnboarding: Bool
    public var closeButtonPressed: (() -> Void)?
    
    convenience init(isOnboarding: Bool) {
        self.init(isOnboarding: isOnboarding, preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(isOnboarding: Bool, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        self.isOnboarding = isOnboarding
        
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

extension CityListViewModel: CityListViewModeling {
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    public func getNumberOfCities() -> Int {
        return cities.count
    }
    
    public func cityAt(index: Int) -> City {
        return cities[index]
    }
    
    public func saveCurrentCity(at index: Int) {
        let selectedCity = cityAt(index: index)
        preferencesManager.currentCityId = selectedCity.id
    }
    
    public func getCurrentCityName() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.name ?? ""
    }
    
    public func getCurrentCityImage() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.imageUrl ?? ""
    }
}
