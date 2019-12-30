//
//  MainCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = MenuViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = MenuViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    @objc func openCityList() {
        let vc = CityListViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = CityListViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
