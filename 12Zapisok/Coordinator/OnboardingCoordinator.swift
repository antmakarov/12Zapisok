//
//  OnboardingCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum OnboardingRoute: Route {
    case auth
    case cityList(completion: ((City) -> Void)?)
    case finishOnboarding
}

protocol OnboardingViewModelCoordinatorDelegate: class {
    func prepareRouting(for route: OnboardingRoute)
}

class OnboardingCoordinator: BaseCoordinator {
        
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = OnboardingViewController()
        let vm = OnboardingViewModel()
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
}

extension OnboardingCoordinator: OnboardingViewModelCoordinatorDelegate {
    
    func prepareRouting(for route: OnboardingRoute) {
        switch route {
        case .auth:
            let vc = LoginViewController()
            navigationController.pushViewController(vc, animated: true)
            
        case .cityList(let completion):
            let vc = CityListViewController()
            vc.viewModel = CityListViewModel()
            vc.chooseCompletion = completion
            navigationController.pushViewController(vc, animated: true)
            
        case .finishOnboarding:
            finishFlow?()
        }
    }
}
