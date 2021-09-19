//
//  CityDetailsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

enum CityDetailsRoute {
    case map
    case back
}

protocol CityDetailsViewModeling {
    var routeTo: ((CityDetailsRoute) -> Void)? { get set }
    func getName() -> String
    func getImageCount() -> Int
    func getImageUrl(by index: Int) -> String
    func getDescription() -> String
    func getBuildingYear() -> String
    func getPopulation() -> String
    func getRegionCode() -> String
}

final class CityDetailsViewModel {
    
    // MARK: Managers
    private let preferencesManager: PreferencesManager
    private let databaseStorage: CoreDataManager
    
    // MARK: Private / Public variables
    private var currentCity: City?
    private var imageUrls: [String] = []
    var routeTo: ((CityDetailsRoute) -> Void)?

    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: CoreDataManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: CoreDataManager) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage

        configureData()
    }
    
    private func configureData() {
        if let cityID = preferencesManager.currentCityId {
            currentCity = databaseStorage.fetchObjectById(entityClass: City.self, id: cityID)
        }
    }
}

extension CityDetailsViewModel: CityDetailsViewModeling {
    
    func getName() -> String {
        return currentCity?.name ?? .empty
    }
    
    func getImageUrl(by index: Int) -> String {
        return currentCity?.details?.images[index] ?? .empty
    }
    
    func getImageCount() -> Int {
        return currentCity?.details?.images.count ?? 0
    }
    
    func getDescription() -> String {
        return currentCity?.description ?? .empty
    }
    
    // TODO: Need some converter for buid/population/code
    
    func getBuildingYear() -> String {
        guard let currentCity = currentCity?.details else {
            return .empty
        }
        return "\(currentCity.baseYear) г"
    }
    
    func getPopulation() -> String {
        guard let currentCity = currentCity?.details else {
            return .empty
        }
        return "\(currentCity.population) млн"
    }
    
    func getRegionCode() -> String {
        guard let currentCity = currentCity?.details else {
            return .empty
        }
        return "\(currentCity.regionCode) RUS"
    }
}
