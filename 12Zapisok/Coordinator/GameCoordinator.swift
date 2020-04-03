//
//  GameCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 17.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum GameRouter {
    case note(viewModel: GameNoteViewModeling)
    case map
    case purchase
    case back
}

class GameCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private var cityName: String
    
    init(cityName: String, navigationController: UINavigationController) {
        self.cityName = cityName
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = GameViewController()
        let vm = GameViewModel(cityName: cityName)
        vm.routeTo = { [weak self] route in
            self?.manageRoute(route)
        }
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
    
    func manageRoute(_ route: GameRouter) {
        switch route {
        case .map:
            let mapCoordinator = MapCoordinator(navigationController: navigationController)
            mapCoordinator.finishFlow = { [weak self] in
                self?.removeChildCoordinator(mapCoordinator)
                self?.navigationController.popViewController(animated: true)
            }
            addChildCoordinator(mapCoordinator)
            mapCoordinator.start()
            
        case .note(var viewModel):
            let viewController = GameNoteViewController()
            viewController.viewModel = viewModel
            viewModel.routeTo = { [weak self] route in
                switch route {
                case .map:
                    self?.navigationController.viewControllers.last?.modalEffect(action: .dismiss)

                    self?.manageRoute(.map)
                    
                case .purchase:
                    self?.manageRoute(.purchase)
                    
                case .back:
                    self?.navigationController.viewControllers.last?.modalEffect(action: .dismiss)
                    //self?.navigationController.popViewController(animated: true)
                    
                case .note:
                    break
                }
            }
           
            navigationController.viewControllers.last?.modalEffect(action: .present, viewController)
                    
        case .purchase:
            let viewController = PurchaseViewController()
            let viewModel = PurchaseViewModel()
            viewModel.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
            viewController.viewModel = viewModel
            navigationController.pushViewController(viewController, animated: true)
            
        case .back:
            finishFlow?()
        }
    }
}
