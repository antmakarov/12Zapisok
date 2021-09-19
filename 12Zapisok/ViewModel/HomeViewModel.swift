//
//  HomeViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

protocol CurrentCityProtocol {
    func getCurrentCityName() -> String
    func getCurrentCityImage() -> String
}

protocol HomeViewModeling: CurrentCityProtocol {
    func getCurrentCityScore() -> Int
    var routeTo: ((HomeRoute) -> Void)? { get set }
    var updateCityHandler: (() -> Void)? { get set }
}

final class HomeViewModel {

    // MARK: Managers
    private let preferencesManager: PreferencesManager
    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging
    
    // MARK: Private / Public variables
    private var currentCity: City?
    
    public var updateCityHandler: (() -> Void)?
    public var routeTo: ((HomeRoute) -> Void)?

    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: CoreDataManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: CoreDataManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager

        configureHomeData()
        configureBinding()
    }

    // MARK: - 
    private func configureBinding() {
        preferencesManager.updateCityIdHandler = { [weak self] id in
            self?.currentCity = self?.databaseStorage.fetchObjectById(entityClass: City.self, id: id)
        }
    }

    private func configureHomeData() {
        if let cityID = preferencesManager.currentCityId {
            currentCity = databaseStorage.fetchObjectById(entityClass: City.self, id: cityID)
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
