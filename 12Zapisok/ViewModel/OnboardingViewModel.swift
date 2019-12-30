//
//  OnboardingViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

enum OnbordingItem: Int, CaseIterable {
    case details
    case location
    case city
    case auth
}

protocol OnboardingViewModelProtocol: class {
    func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModelProtocol
    func onboardingItems() -> Int
    func didTapSkip()
}

class OnboardingViewModel {
    
    weak var coordinatorDelegate: OnboardingViewModelCoordinatorDelegate?
    private var onboardingSteps: [OnboardingStepViewModelProtocol] = []
    private let locationManager: LocationManagerProtocol
    private var cityName: String?

    convenience init() {
        self.init(locationManager: LocationManager.shared)
    }
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    private func requestLocationAuthorization(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    
    func onboardingItem(type: OnbordingItem) -> OnboardingStepViewModelProtocol {
        
        switch type {
        case .details:
            return OnboardingStepViewModel(title: "Вернитесь в детство", details: "Сыграйте в увлекательную игру, где Вам предстоит собрать 12 записок спрятанных в Вашем городе", image: "", actionTitle: "Далее", isHideSkip: true) { completion in
                    completion(true)
            }
            
        case .location:
            return OnboardingStepViewModel(title: "Доступ к геолокации", details: "Позволит точнее определить Ваше местоположение и облегчит игру", image: "", actionTitle: "Разрешить") { completion in
                self.locationManager.requestAuthorization { result in
                    if !result {
                        completion(false)
                    } else {
                        self.locationManager.requestCurrentLocation { location in
                            self.cityName = "Ni Ni"
                            completion(true)
                        }
                    }
                }
            }
        
        case .city:
            if let city = cityName {
                return OnboardingStepViewModel(title: city, details: "Правильно ли мы определили Ваш город?", image: "", actionTitle: "Выбрать город") { completion in
                    self.coordinatorDelegate?.didTapCityList { city in
                        print(city)
                    }
                }
            } else {
                return OnboardingStepViewModel(title: "Выберете Ваш город", details: "Мы заметили, что Вы запретили геолокацию, в этом случае выберите город из списка для начала игры", image: "", actionTitle: "Выбрать город", isHideSkip: true) { completion in
                    self.coordinatorDelegate?.didTapCityList { city in
                        print(city)
                    }
                }
            }

            
        case .auth:
            return OnboardingStepViewModel(title: "Ведите прогресс", details: "Авторизируйтесь для сохранения прогресса и участия в общем рейтиге игроков", image: "", actionTitle: "Войти") { completion in
                self.didTapSkip()
            }            
        }
    }
    
    func onboardingItems() -> Int {
        return OnbordingItem.allCases.count
    }
    
    func didTapSkip() {
        coordinatorDelegate?.didFinish(returnValue: "")
    }
    
}
