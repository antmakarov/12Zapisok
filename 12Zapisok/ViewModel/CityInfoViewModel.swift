//
//  CityInfoViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

enum CityInfoRoute {
    case map
    case back
}

protocol CityInfoViewModeling {
    var routeTo: ((CityInfoRoute) -> Void)? { get set }
    func getName() -> String
    func getImageCount() -> Int
    func getImageUrl(by index: Int) -> String
    func getDescription() -> String
    func getBuildingYear() -> String
    func getPopulation() -> String
    func getRegionCode() -> String
}

final class CityInfoViewModel {
    
    // MARK: Managers
    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    
    // MARK: Private / Public variables
    private var currentCity: CityInfo?
    private var imageUrls: [String] = []
    var routeTo: ((CityInfoRoute) -> Void)?

    convenience init() {
        self.init(preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared)
    }
    
    init(preferencesManager: PreferencesManager, databaseStorage: StorageManager) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage

        loadCurrentCity()
    }
    
    private func loadCurrentCity() {
        if let cityID = preferencesManager.currentCityId {
            currentCity = databaseStorage.getObjectByID(City.self, id: cityID)?.cityInfo
        }
    }
}

extension CityInfoViewModel: CityInfoViewModeling {
    
    func getName() -> String {
        return currentCity?.name ?? .empty
    }
    
    func getImageUrl(by index: Int) -> String {
        return currentCity?.imageUrls[index] ?? .empty
    }
    
    func getImageCount() -> Int {
        return currentCity?.imageUrls.count ?? 0
    }
    
    func getDescription() -> String {
        return currentCity?.fullDescription ?? .empty
    }
    
    // TODO: Need some converter for buid/population/code
    
    func getBuildingYear() -> String {
        guard let currentCity = currentCity else {
            return .empty
        }
        return "\(currentCity.baseYear) г"
    }
    
    func getPopulation() -> String {
        guard let currentCity = currentCity else {
            return .empty
        }
        return "\(currentCity.population) млн"
    }
    
    func getRegionCode() -> String {
        guard let currentCity = currentCity else {
            return .empty
        }
        return "\(currentCity.regionCode) RUS"
    }
}
