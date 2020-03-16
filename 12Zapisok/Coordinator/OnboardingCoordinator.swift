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

protocol OnboardingCoordinatorDelegate: class {
    func didFinishOnboarding(from coordinator: OnboardingCoordinator)
}

protocol OnboardingViewModelCoordinatorDelegate: class {
    func prepareRouting(for route: OnboardingRoute)
}

class OnboardingCoordinator: BaseCoordinator {
        
    var rootViewController: UINavigationController
    weak var delegate: OnboardingCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        rootViewController = navigationController
    }

    override func start() {
        let vc = OnboardingViewController()
        let vm = OnboardingViewModel()
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        rootViewController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        rootViewController.popViewController(animated: true)
        delegate?.didFinishOnboarding(from: self)
    }
}

extension OnboardingCoordinator: OnboardingViewModelCoordinatorDelegate {
    
    func prepareRouting(for route: OnboardingRoute) {
        switch route {
        case .auth:
            let vc = LoginViewController()
            rootViewController.pushViewController(vc, animated: true)
            
        case .cityList(let completion):
            let vc = CityListViewController()
            vc.viewModel = CityListViewModel()
            vc.chooseCompletion = completion
            rootViewController.pushViewController(vc, animated: true)
            
        case .finishOnboarding:
            finish()
        }
    }
}
