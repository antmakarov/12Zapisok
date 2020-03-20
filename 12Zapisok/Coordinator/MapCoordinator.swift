//
//  MapCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum MapRouter {
    case purchase
    case back
}

class MapCoordinator: BaseCoordinator {
 
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let mapViewController = MapViewController()
        let mapViewModel = MapViewModel()
        mapViewModel.routeTo = { [weak self] route in
            self?.manageRoute(route)
        }
        mapViewController.viewModel = mapViewModel
        navigationController.pushViewController(mapViewController, animated: true)
    }
    
    private func manageRoute(_ route: MapRouter) {
        switch route {
        case .purchase:
            let vc = PurchaseViewController()
            let vm = PurchaseViewModel()
            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            vc.viewModel = vm
            navigationController.pushViewController(vc, animated: true)
            
        case .back:
            finishFlow?()
        }
    }
}
