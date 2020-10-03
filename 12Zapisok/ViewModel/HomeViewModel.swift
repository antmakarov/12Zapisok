//
//  HomeViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CurrentCityProtocol {
    func getCurrentCityName() -> String
    func getCurrentCityImage() -> String
}

protocol HomeViewModeling: CurrentCityProtocol {
    func getCurrentCityScore() -> Int
    var routeTo: ((HomeRoute) -> Void)? { get set }
    var updateCityHandler: (() -> Void)? { get set }
}

class HomeViewModel {

    //MARK: Managers
    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    //MARK: Private / Public variables
    private var currentCity: City?
    
    public var updateCityHandler: (() -> Void)?
    public var routeTo: ((HomeRoute) -> Void)?

    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager

        loadCurrentCity()
        
        preferencesManager.updateCityIdHandler = { [weak self] id in
            self?.currentCity = self?.databaseStorage.getObjectByID(City.self, id: id)
        }
    }
    
    private func loadCurrentCity() {
        if let cityID = preferencesManager.currentCityId {
            currentCity = databaseStorage.getObjectByID(City.self, id: cityID)
        }
    }
}

extension HomeViewModel: HomeViewModeling {
    func getCurrentCityName() -> String {
        return currentCity?.name ?? .empty
    }
    
    func getCurrentCityImage() -> String {
        return currentCity?.imageUrl ?? .empty
    }
    
    func getCurrentCityScore() -> Int {
        return 5
    }
}
