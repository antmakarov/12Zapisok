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

enum OnbordingItem: Int, CaseIterable {
    case details
    case location
    case city
    case auth
}

protocol OnboardingViewModeling: AnyObject {
    func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModeling
    func onboardingItems() -> Int
    
    var routeTo: ((OnboardingRoute) -> Void)? { get set }
}

class OnboardingViewModel {
    
    private enum Constants {
        enum Details {
            static let title = Localized.onboardingGoChildhood
            static let details = Localized.onboardingGoChildhoodDsc
            static let action = Localized.next
            static let image = Asset.Icons.Onboarding.childhood.name
        }
        
        enum Location {
            static let title = Localized.onboardingAccessGeo
            static let details = Localized.onboardingAccessGeoDsc
            static let action = Localized.allow
            static let image = Asset.Icons.Onboarding.requestLocation.name
        }
        
        enum City {
            static let details = Localized.onboardingRightCity
            static let image = Asset.Icons.Onboarding.guessCity.name
        }
        
        enum CityList {
            static let title = Localized.onboardingChooseCity
            static let details = Localized.onboardingAccessGeoDenied
            static let action = Localized.chooseCity
            static let image = Asset.Icons.Onboarding.cityList.name
        }
        
        enum Auth {
            static let title = Localized.onboardingLeadProgress
            static let details = Localized.onboardingAuthDsc
            static let action = Localized.onboardingAuth
            static let image = Asset.Icons.Onboarding.auth.name
        }
    }
    
    // MARK: Managers
    private let locationManager: LocationManaging
    private let networkManager: NetworkManaging
    private let preferencesManager: PreferencesManager
    private let databaseStorage = CoreDataManager.shared

    // MARK: Private / Public variables
    private var onboardingSteps: [OnboardingStepViewModeling] = []
    private var cityName: Int?
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
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.loadCities()
        }
    }
    
    private func loadCities() {
        networkManager.getCityList()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    self.cities = value
                    self.databaseStorage.saveContext()
                  })
            .store(in: &subscription)
    }
    
    private func calculateNearCity(coordinates: MapPoint?) -> Int? {
        
        let avaibleCities = cities.filter { city in
            if let location = city.location {
                return locationManager.distanceFromCoordinates(location.latitude, location.longitude) != 0
            }
            return false
        }
        
        let sortedPlaces = avaibleCities.sorted(by: {
            guard let loc1 = $0.location, let loc2 = $1.location else {
                return false
            }
            return locationManager.distanceFromCoordinates(loc1.latitude, loc1.longitude) < locationManager.distanceFromCoordinates(loc2.latitude, loc2.longitude)
        })
            
        return sortedPlaces.first?.id
    }
}

extension OnboardingViewModel: OnboardingViewModeling {
    
    public func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModeling {
        
        switch type {
        case .details:
            return OnboardingStepViewModel(title: Constants.Details.title, details: Constants.Details.details, image: Constants.Details.image, actionTitle:  Constants.Details.action, isHideSkip: true) { _, completion in
                completion?()
            }
            
        case .location:
            return OnboardingStepViewModel(title: Constants.Location.title, details: Constants.Location.details, image: Constants.Location.image, actionTitle: Constants.Location.action) { type, completion in
                if type == .skip  {
                    completion?()
                    return
                }
                
                self.locationManager.requestAuthorization { result in
                    if !result {
                        completion?()
                    } else {
                        self.locationManager.requestCurrentLocation { [weak self] location in
                            let nearCityId = self?.calculateNearCity(coordinates: location)
                            self?.cityName = nearCityId
                            completion?()
                        }
                    }
                }
            }
            
        case .city:
            if let city = cityName, let name = cities.first(where: { $0.id == city }) {
                return OnboardingStepViewModel(title: name.name, details: Constants.City.details, image: Constants.City.image, actionTitle: .empty, isHideSkip: true, isNeedAnswer: true) { [weak self] type, completion in
                    switch type {
                    case .done:
                        self?.preferencesManager.currentCityId = city
                        completion?()
                        
                    case .denied, .skip:
                        self?.routeTo?(.cityList(completion: { city in
                            completion?()
                        }))
                    }
                }
            } else {
                return OnboardingStepViewModel(title: Constants.CityList.title, details: Constants.CityList.details, image: Constants.CityList.image, actionTitle: Constants.CityList.action, isHideSkip: true) { [weak self] _, completion in
                    self?.routeTo?(.cityList(completion: { city in
                        completion?()
                    }))
                }
            }
            
        case .auth:
            return OnboardingStepViewModel(title: Constants.Auth.title, details: Constants.Auth.details, image: Constants.Auth.image, actionTitle: Constants.Auth.action) { [weak self] _, completion in
                self?.routeTo?(.back)
            }            
        }
    }
    
    public func onboardingItems() -> Int {
        return OnbordingItem.allCases.count
    }
}
