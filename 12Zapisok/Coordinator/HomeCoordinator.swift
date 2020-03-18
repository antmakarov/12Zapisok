//
//  HomeCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum HomeRoute: Route {
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

protocol HomeViewModelCoordinatorDelegate: class {
    func prepareRouting(for route: HomeRoute)
}

class HomeCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = HomeViewController()
        let vm = HomeViewModel()
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func dismissViewControlelr() {
        
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    
    func prepareRouting(for route: HomeRoute) {
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
            vc.viewModel = PurchaseViewModel()
            navigationController.pushViewController(vc, animated: true)

        case .showRules:
            let vc = GameRulesViewController()
            vc.viewModel = GameRulesViewModel()
            navigationController.pushViewController(vc, animated: true)
            
        case .showCityList:
            let vc = CityListViewController()
            vc.viewModel = CityListViewModel()
            navigationController.pushViewController(vc, animated: true)

        case .showSettings:
            let vc = SettingsViewController()
            vc.viewModel = SettingsViewModel()
            navigationController.pushViewController(vc, animated: false)
            
        case .showLeaders:
            let vc = LeaderboardViewController()
            vc.viewModel = LeaderboardViewModel()
            navigationController.pushViewController(vc, animated: true)
            
        case .showStatistics:
            let vc = StatisticsViewController()
            vc.viewModel = StatisticsViewModel()
            navigationController.pushViewController(vc, animated: true)
            
        case .showCityInfo:
            let vc = CityInfoViewController()
            navigationController.pushViewController(vc, animated: true)
            
        case .showMap:
            let vc = MapViewController()
            vc.viewModel = MapViewModel()
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
