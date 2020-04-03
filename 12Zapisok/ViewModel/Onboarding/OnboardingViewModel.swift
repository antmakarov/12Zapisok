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
    
    //MARK: Managers
    private let locationManager: LocationManaging
    private let networkManager: NetworkManaging
    
    //MARK: Private / Public variables
    private var onboardingSteps: [OnboardingStepViewModeling] = []
    private var cityName: Int?
    private var cities: [City]?
    
    public var routeTo: ((OnboardingRoute) -> Void)?
    
    convenience init() {
        self.init(locationManager: LocationManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(locationManager: LocationManaging, networkManager: NetworkManaging) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        loadCities()
    }
    
    private func requestLocationAuthorization(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    private func loadCities() {
        networkManager.getCityList { result in
            switch result {
                
            case .success(let cities):
                self.cities = cities
                
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
        }
    }
    
    private func calculateNearCity(coordinates: MapPoint?) -> Double {
        var id = 0
        if let avaibleCities = cities?.filter({ city in
            locationManager.distanceFromPoint(CLLocation(latitude: city.location!.lat, longitude: city.location!.lon)) != 0 }) {
            let sortedPlaces = avaibleCities.sorted(by: { city1, city2  in
                if let c1 = city1.location, let c2 = city2.location  {
                    let distance1 = locationManager.distanceFromPoint(CLLocation(latitude: c1.lat, longitude: c1.lon))
                    let distance2 = locationManager.distanceFromPoint(CLLocation(latitude: c2.lat, longitude: c2.lon))
                    
                    return distance1 < distance2
                }
                
                return false
            })
            
            id = sortedPlaces.first?.id ?? 0
        }
        
        return Double(id)
    }
}

extension OnboardingViewModel: OnboardingViewModeling {
    
    public func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModeling {
        
        switch type {
        case .details:
            return OnboardingStepViewModel(title: "Вернитесь в детство", details: "Сыграйте в увлекательную игру, где Вам предстоит собрать 12 записок спрятанных в Вашем городе", image: "", actionTitle: "Далее", isHideSkip: true) { _, completion in
                completion?()
            }
            
        case .location:
            return OnboardingStepViewModel(title: "Доступ к геолокации", details: "Позволит точнее определить Ваше местоположение и облегчит игру", image: "", actionTitle: "Разрешить") { type, completion in
                guard type != .skip else {
                    completion?()
                    return
                }
                
                self.locationManager.requestAuthorization { result in
                    if !result {
                        completion?()
                    } else {
                        self.locationManager.requestCurrentLocation { location in
                            let r = self.calculateNearCity(coordinates: location)
                            print(r)
                            self.cityName = Int(r)
                            completion?()
                        }
                    }
                }
            }
            
        case .city:
            if let city = cityName, let name = cities?.first(where: { $0.id == city }) {
                return OnboardingStepViewModel(title: name.name, details: "Правильно ли мы определили Ваш город?", image: .empty, actionTitle: .empty, isHideSkip: true, isNeedAnswer: true) { type, completion in
                    switch type {
                    case .done:
                        completion?()
                        
                    case .denied, .skip:
                        self.routeTo?(.cityList(completion: { city in
                            print(city)
                            completion?()
                        }))
                    }
                }
            } else {
                return OnboardingStepViewModel(title: "Выберете Ваш город", details: "Мы заметили, что Вы запретили геолокацию, в этом случае выберите город из списка для начала игры", image: "", actionTitle: "Выбрать город", isHideSkip: true) { _, completion in
                    self.routeTo?(.cityList(completion: { city in
                        print(city)
                        completion?()
                    }))
                }
            }
            
        case .auth:
            return OnboardingStepViewModel(title: "Ведите прогресс", details: "Авторизируйтесь для сохранения прогресса и участия в общем рейтиге игроков", image: "", actionTitle: "Войти") { _, completion in
                self.routeTo?(.back)
            }            
        }
    }
    
    public func onboardingItems() -> Int {
        return OnbordingItem.allCases.count
    }
}
