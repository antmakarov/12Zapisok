//
//  OnboardingViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable all

import Foundation
import CoreLocation
import Combine

protocol OnboardingViewModeling: AnyObject {
    func onboardingItem(at index: Int) -> OnboardingStepViewModeling
    func onboardingItemsCount() -> Int
    
    var routeTo: ((OnboardingRoute) -> Void)? { get set }
}

class OnboardingViewModel {
    
    // MARK: Managers

    private let locationManager: LocationManaging
    private let networkManager: NetworkManaging
    private let preferencesManager: PreferencesManager
    private let databaseStorage = CoreDataManager.shared

    // MARK: Private / Public variables

    private var onboardingItems = OnbordingItem.allCases
    private var onboardingSteps: [OnboardingStepViewModeling] = []
    private var chosenСityId: Int?
    private var cities = [City]()
    private var subscription = Set<AnyCancellable>()

    public var routeTo: ((OnboardingRoute) -> Void)?
    
    convenience init() {
        self.init(locationManager: LocationManager.shared,
                  networkManager: NetworkManager.shared,
                  preferencesManager: PreferencesManager.shared)
    }
    
    init(locationManager: LocationManaging,
         networkManager: NetworkManaging,
         preferencesManager: PreferencesManager) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.preferencesManager = preferencesManager
        
        getCityList()
    }

    // MARK: Working with city list
    
    private func getCityList() {
        networkManager.getCityList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.mark()

                case let .failure(error):
                    Logger.error(msg: error)
                }
            },
            receiveValue: { [weak self] value in
                self?.cities = value
            })
            .store(in: &subscription)
    }
    
    private func findNearestCity(coordinates: Location?) -> City? {

        // MARK: Get all cities with available locations

        let availableCities = cities.filter { city in
            guard let location = city.location else {
                return false
            }
            return locationManager.distanceFrom(location) != 0
        }

        // MARK: Sorting to find the nearest city

        let sortedCities = availableCities.sorted(by: {
            guard let loc0 = $0.location,
                  let loc1 = $1.location else {
                return false
            }
            return locationManager.distanceFrom(loc0) < locationManager.distanceFrom(loc1)
        })

        return sortedCities.first
    }
}

// MARK: - OnboardingViewModeling Public Methods

extension OnboardingViewModel: OnboardingViewModeling {
    
    public func onboardingItem(at index: Int) -> OnboardingStepViewModeling {
        
        switch onboardingItems[index] {
        case .details:
            return OnboardingStepViewModel(title: Constants.Details.title,
                                           details: Constants.Details.details,
                                           image: Constants.Details.image,
                                           actionTitle:  Constants.Details.action,
                                           isHideSkip: true) { _, completion in
                completion?()
            }
            
        case .location:
            return OnboardingStepViewModel(title: Constants.Location.title,
                                           details: Constants.Location.details,
                                           image: Constants.Location.image,
                                           actionTitle: Constants.Location.action) { [weak self] type, completion in
                if type == .skip  {
                    completion?()
                    return
                }
                
                self?.locationManager.requestAuthorization { result in
                    if !result {
                        completion?()
                    } else {
                        self?.locationManager.requestCurrentLocation { [weak self] location in
                            self?.chosenСityId = self?.findNearestCity(coordinates: location)?.id
                            completion?()
                        }
                    }
                }
            }
            
        case .city:
            if let cityId = chosenСityId, let name = cities.first(where: { $0.id == cityId }) {
                return OnboardingStepViewModel(title: name.name,
                                               details: Constants.City.details,
                                               image: Constants.City.image,
                                               actionTitle: .empty,
                                               isHideSkip: true,
                                               isNeedAnswer: true) { [weak self] type, completion in
                    switch type {
                    case .done:
                        self?.preferencesManager.currentCityId = cityId
                        completion?()
                        
                    case .denied, .skip:
                        self?.routeTo?(.cityList(completion: { city in
                            completion?()
                        }))
                    }
                }
            } else {
                return OnboardingStepViewModel(title: Constants.CityList.title,
                                               details: Constants.CityList.details,
                                               image: Constants.CityList.image,
                                               actionTitle: Constants.CityList.action,
                                               isHideSkip: true) { [weak self] _, completion in
                    self?.routeTo?(.cityList(completion: { city in
                        completion?()
                    }))
                }
            }
            
        case .auth:
            return OnboardingStepViewModel(title: Constants.Auth.title,
                                           details: Constants.Auth.details,
                                           image: Constants.Auth.image,
                                           actionTitle: Constants.Auth.action) { [weak self] _, completion in
                self?.routeTo?(.back)
            }
        }
    }
    
    public func onboardingItemsCount() -> Int {
        return onboardingItems.count
    }
}
