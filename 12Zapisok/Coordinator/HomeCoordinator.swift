//
//  HomeCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum HomeRoute {
    //TODO: Change one name to extended information
    case showGame(cityName: String)
    case showPurchase
    case showRules
    case showCityList
    case showSettings
    case showLeaders
    case showStatistics
    case showMap
    case showCityInfo
}

class HomeCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    private let rootViewModel = HomeViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        rootViewModel.routeTo = { [weak self] route in
            self?.manageRoute(route)
        }
        let rootViewController = HomeViewController()
        rootViewController.viewModel = rootViewModel
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    private func presentModally(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .automatic
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    //TODO: Replace this to some BuilderViewController
    private func manageRoute(_ route: HomeRoute) {
        switch route {
        case .showGame(let cityName):
            let gameCoordinator = GameCoordinator(cityName: cityName, navigationController: navigationController)
            gameCoordinator.finishFlow = { [weak self] in
                self?.removeChildCoordinator(gameCoordinator)
                self?.navigationController.popViewController(animated: true)
            }
            
            addChildCoordinator(gameCoordinator)
            gameCoordinator.start()
            
        case .showPurchase:
            let vc = PurchaseViewController()
            let vm = PurchaseViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)

        case .showRules:
            let vc = GameRulesViewController()
            let vm = GameRulesViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)
            
        case .showCityList:
            let vc = CityListViewController()
            let vm = CityListViewModel(isOnboarding: false)
            vm.closeButtonPressed = { [weak self] in
                //TODO: Change to listener binding
                self?.rootViewModel.updateCityHandler?()
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)

        case .showSettings:
            let vc = SettingsViewController()
            let vm = SettingsViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)
            
        case .showLeaders:
            let vc = LeaderboardViewController()
            let vm = LeaderboardViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)
            
        case .showStatistics:
            let vc = StatisticsViewController()
            let vm = StatisticsViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.dismiss(animated: true)
            }
            vc.viewModel = vm
            presentModally(vc)
            
        case .showCityInfo:
            let vc = CityInfoViewController()
            let vm = CityInfoViewModel()
            vm.routeTo = { [weak self] route in
                switch route {
                case .map:
                    self?.navigationController.dismiss(animated: true) {
                        self?.manageRoute(.showMap)
                    }
                    
                case .back:
                    self?.navigationController.dismiss(animated: true)
                }
            }
            vc.viewModel = vm
            presentModally(vc)
            
        case .showMap:
            let mapCoordinator = MapCoordinator(navigationController: navigationController)
            mapCoordinator.finishFlow = { [weak self] in
                self?.removeChildCoordinator(mapCoordinator)
                self?.navigationController.popViewController(animated: true)
            }
            addChildCoordinator(mapCoordinator)
            mapCoordinator.start()
        }
    }
}
