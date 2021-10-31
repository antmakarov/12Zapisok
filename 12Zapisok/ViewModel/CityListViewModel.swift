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

protocol CityListViewModeling: CurrentCityProtocol, ObservableObject {
    func saveCurrentCity(at index: Int)
    func hasChosenCity() -> Bool
    func fetchCities()

    var isOnboarding: Bool { get }
    var citiesSU: [City] { get }
    var updateHandler: (() -> Void)? { get set }
    var closeButtonPressed: (() -> Void)? { get set }
}

final class CityListViewModel {
    
    private let preferencesManager: PreferencesManager
    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging

    private var subscription = Set<AnyCancellable>()

    public var isOnboarding: Bool
    public var closeButtonPressed: (() -> Void)?
    public var updateHandler: (() -> Void)?

    @Published var citiesSU = [City]()

    convenience init(isOnboarding: Bool) {
        self.init(isOnboarding: isOnboarding,
                  preferencesManager: PreferencesManager.shared,
                  databaseStorage: CoreDataManager.shared,
                  networkManager: NetworkManager.shared)
    }

    init(isOnboarding: Bool,
         preferencesManager: PreferencesManager,
         databaseStorage: CoreDataManager,
         networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        self.isOnboarding = isOnboarding
    }
}

extension CityListViewModel: CityListViewModeling {

    public func fetchCities() {
        networkManager.getCityList()
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure(let error):
                    Logger.error(msg: error)

                case .finished:
                    Logger.mark()
                }
            } receiveValue: { value in
                self.databaseStorage.saveContext()
                self.citiesSU = value
            }
            .store(in: &subscription)
    }

    
    public func hasChosenCity() -> Bool {
        return citiesSU.contains { $0.id == preferencesManager.currentCityId }
    }
    
    public func saveCurrentCity(at index: Int) {
        let selectedCity = cityAt(index: index)
        preferencesManager.currentCityId = selectedCity.id
    }
    
    public func getCurrentCityName() -> String {
        return citiesSU.first { $0.id == preferencesManager.currentCityId }?.name ?? .empty
    }
    
    public func getCurrentCityImage() -> String {
        return citiesSU.first { $0.id == preferencesManager.currentCityId }?.imageUrl ?? .empty
    }
}
