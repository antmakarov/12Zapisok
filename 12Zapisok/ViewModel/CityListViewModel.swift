//
//  CityListViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable force_cast

import Combine
import CoreData

protocol CityListViewModeling: CurrentCityProtocol {
    func getNumberOfCities() -> Int
    func cityAt(index: Int) -> City
    func saveCurrentCity(at index: Int)
    func hasChosenCity() -> Bool
    func fetchCities()
    var namePublisher: Published<[City]>.Publisher { get }

    var isOnboarding: Bool { get }
    var closeButtonPressed: (() -> Void)? { get set }
}

final class CityListViewModel {
    
    private let preferencesManager: PreferencesManager
    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging
    
    private var cities = [City]()
    private var updateHandler: (() -> Void)?
    
    public var isOnboarding: Bool
    public var closeButtonPressed: (() -> Void)?

    @Published var cities2 = [City]()
    var namePublisher: Published<[City]>.Publisher { $cities2 }

    private var networkManager2 = NetworkManager()
    private var subscription = Set<AnyCancellable>()

    convenience init(isOnboarding: Bool) {
        self.init(isOnboarding: isOnboarding, preferencesManager: PreferencesManager.shared, databaseStorage: CoreDataManager.shared, networkManager: NetworkManager.shared)
    }

    init(isOnboarding: Bool, preferencesManager: PreferencesManager, databaseStorage: CoreDataManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        self.isOnboarding = isOnboarding
        
        fetchCities()
    }
}

extension CityListViewModel: CityListViewModeling {

    func fetchPresistantData() {
        self.cities = databaseStorage.fetchObjects(entityClass: City.self)
    }

    public func fetchCities() {
        networkManager2.getCityList()
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure(let error):
                    Logger.error(msg: error)

                case .finished:
                    Logger.mark()
                }
            } receiveValue: { resultArr in
                Logger.info(msg: resultArr)
                self.databaseStorage.saveContext()
                self.fetchPresistantData()
                self.updateHandler?()
            }
            .store(in: &subscription)
    }
    
    public func getNumberOfCities() -> Int {
        return cities.count
    }
    
    public func cityAt(index: Int) -> City {
        return cities[index]
    }
    
    public func hasChosenCity() -> Bool {
        return cities.contains { $0.id == preferencesManager.currentCityId }
    }
    
    public func saveCurrentCity(at index: Int) {
        let selectedCity = cityAt(index: index)
        preferencesManager.currentCityId = selectedCity.id
    }
    
    public func getCurrentCityName() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.name ?? .empty
    }
    
    public func getCurrentCityImage() -> String {
        return cities.first { $0.id == preferencesManager.currentCityId }?.imageUrl ?? .empty
    }
}
