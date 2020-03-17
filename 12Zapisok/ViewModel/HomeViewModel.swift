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
    func routeTo(_ route: HomeRoute)
    func dismiss()
}

class HomeViewModel {

    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?

    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    private var currentCity: City?
    
    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
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

extension HomeViewModel: HomeViewModeling {
    func getCurrentCityName() -> String {
        return currentCity?.name ?? ""
    }
    
    func getCurrentCityImage() -> String {
        return currentCity?.imageUrl ?? ""
    }
    
    func getCurrentCityScore() -> Int {
        return 5
    }
    
    func routeTo(_ route: HomeRoute) {
        coordinatorDelegate?.prepareRouting(for: route)
    }
    
    func dismiss() {
        coordinatorDelegate?.dismiss()
    }
}
