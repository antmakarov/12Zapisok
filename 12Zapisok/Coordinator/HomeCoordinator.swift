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
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func prepareRouting(for route: HomeRoute) {
        
        switch route {
        case .showGame:
            let gameCoordinator = GameCoordinator(navigationController: navigationController)
            addChildCoordinator(gameCoordinator)
            gameCoordinator.start()
            
        case .showPurchase:
            print()
            
        case .showRules:
            print()
            
        case .showCityList:
            let vc = CityListViewController()
            vc.viewModel = CityListViewModel()
            navigationController.pushViewController(vc, animated: true)

        case .showSettings:
            print()
            
        case .showLeaders:
            print()
            
        case .showStatistics:
            print()
            
        case .showCityInfo:
            print()
            
        case .showMap:
            print()
        }
    }
}
