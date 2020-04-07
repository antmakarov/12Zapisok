//
//  OnboardingViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import CoreLocation

enum OnbordingItem: Int, CaseIterable {
    case details
    case location
    case city
    case auth
}

protocol OnboardingViewModeling: class {
    func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModeling
    func onboardingItems() -> Int
    
    var routeTo: ((OnboardingRoute) -> Void)? { get set }
}

class OnboardingViewModel {
    
    private enum Constants {
        enum Details {
            static let title = "Вернитесь в детство"
            static let details = "Сыграйте в увлекательную игру, где Вам предстоит собрать 12 записок спрятанных в Вашем городе"
            static let action = "Далее"
            static let image = "childhood"
        }
        
        enum Location {
            static let title = "Доступ к геолокации"
            static let details = "Позволит точнее определить Ваше местоположение и облегчит игру"
            static let action = "Разрешить"
            static let image = "requestLocation"
        }
        
        enum City {
            static let details = "Правильно ли мы определили Ваш город?"
            static let image = "guessCity"
        }
        
        enum CityList {
            static let title = "Выберете Ваш город"
            static let details = "Мы заметили, что Вы запретили геолокацию, в этом случае выберите город из списка для начала игры"
            static let action = "Выбрать город"
            static let image = "cityList"
        }
        
        enum Auth {
            static let title = "Ведите прогресс"
            static let details = "Авторизируйтесь для сохранения прогресса и участия в общем рейтиге игроков"
            static let action = "Войти"
            static let image = "auth"
        }
    }
    
    //MARK: Managers
    private let locationManager: LocationManaging
    private let networkManager: NetworkManaging
    private let preferencesManager: PreferencesManager
    private let databaseStorage = StorageManager.shared

    //MARK: Private / Public variables
    private var onboardingSteps: [OnboardingStepViewModeling] = []
    private var cityName: Int?
    private var cities = [City]()
    
    public var routeTo: ((OnboardingRoute) -> Void)?
    
    convenience init() {
        self.init(locationManager: LocationManager.shared, networkManager: NetworkManager.shared, preferencesManager: PreferencesManager.shared)
    }
    
    init(locationManager: LocationManaging, networkManager: NetworkManaging, preferencesManager: PreferencesManager) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.preferencesManager = preferencesManager
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.loadCities()
        }
    }
    
    private func loadCities() {
        networkManager.getCityList { result in
            switch result {
                
            case .success(let cities):
                self.cities = cities
                self.cities.forEach { try? self.databaseStorage.storeObject($0) }
                
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
    }
    
    private func calculateNearCity(coordinates: MapPoint?) -> Int? {
        
        let avaibleCities = cities.filter({ city in
            if let location = city.location {
                return locationManager.distanceFromCoordinates(location.lat, location.lon) != 0
            }
            return false
        })
        
        let sortedPlaces = avaibleCities.sorted(by: {
            guard let loc1 = $0.location, let loc2 = $1.location else {
                return false
            }
            return locationManager.distanceFromCoordinates(loc1.lat, loc1.lon) < locationManager.distanceFromCoordinates(loc2.lat, loc2.lon)
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
                }
                
                self.locationManager.requestAuthorization { result in
                    if !result {
                        completion?()
                    } else {
                        self.locationManager.requestCurrentLocation { location in
                            let nearCityId = self.calculateNearCity(coordinates: location)
                            self.cityName = nearCityId
                            completion?()
                        }
                    }
                }
            }
            
        case .city:
            if let city = cityName, let name = cities.first(where: { $0.id == city }) {
                return OnboardingStepViewModel(title: name.name, details: Constants.City.details, image: Constants.City.image, actionTitle: .empty, isHideSkip: true, isNeedAnswer: true) { type, completion in
                    switch type {
                    case .done:
                        self.preferencesManager.currentCityId = city
                        completion?()
                        
                    case .denied, .skip:
                        self.routeTo?(.cityList(completion: { city in
                            completion?()
                        }))
                    }
                }
            } else {
                return OnboardingStepViewModel(title: Constants.CityList.title, details: Constants.CityList.details, image: Constants.CityList.image, actionTitle: Constants.CityList.action, isHideSkip: true) { _, completion in
                    self.routeTo?(.cityList(completion: { city in
                        completion?()
                    }))
                }
            }
            
        case .auth:
            return OnboardingStepViewModel(title: Constants.Auth.title, details: Constants.Auth.details, image: Constants.Auth.image, actionTitle: Constants.Auth.action) { _, completion in
                self.routeTo?(.back)
            }            
        }
    }
    
    public func onboardingItems() -> Int {
        return OnbordingItem.allCases.count
    }
}
