//
//  HomeCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum HomeRoute {
    case showGame(cityName: String?)
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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = HomeViewController()
        let vm = HomeViewModel()
        vm.routeTo = { [weak self] route in
            self?.manageRoute(route)
        }
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: false)
    }
    
    //TODO: Replace this to some BuilderViewController
    private func manageRoute(_ route: HomeRoute) {
        switch route {
        case .showGame:
            let gameCoordinator = GameCoordinator(navigationController: navigationController)
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
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)

        case .showRules:
            let vc = GameRulesViewController()
            let vm = GameRulesViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
        case .showCityList:
            let vc = CityListViewController()
            let vm = CityListViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)

        case .showSettings:
            let vc = SettingsViewController()
            let vm = SettingsViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
        case .showLeaders:
            let vc = LeaderboardViewController()
            let vm = LeaderboardViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
        case .showStatistics:
            let vc = StatisticsViewController()
            let vm = StatisticsViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
        case .showCityInfo:
            let vc = CityInfoViewController()
            let vm = CityInfoViewModel()
            vm.routeTo = { [weak self] route in
                switch route {
                case .map:
                    self?.manageRoute(.showMap)

                case .back:
                    self?.navigationController.popViewController(animated: true)
                }
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
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
