//
//  HomeCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum HomeRoute: String, Route {
    case showGame
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
    
    var rootViewController: UINavigationController
    
    init(navigationController: UINavigationController) {
        rootViewController = navigationController
    }

    override func start() {
        let vc = HomeViewController()
        let vm = HomeViewModel()
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        rootViewController.pushViewController(vc, animated: false)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func prepareRouting(for route: HomeRoute) {
        
        switch route {
        case .showGame:
            let vc = GameViewController()
            vc.viewModel = GameViewModel()
            rootViewController.pushViewController(vc, animated: true)

        case .showPurchase:
            print()
            
        case .showRules:
            print()
            
        case .showCityList:
            let vc = CityListViewController()
            vc.viewModel = CityListViewModel()
            rootViewController.pushViewController(vc, animated: true)

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
