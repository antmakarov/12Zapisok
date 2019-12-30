//
//  OnboardingCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

protocol OnboardingViewModelCoordinatorDelegate: class {
    func didFinish(returnValue: String)
    func didTapAuth()
    func didTapCityList(completion: ((City) -> Void)?)
}

class OnboardingCoordinator: BaseCoordinator {
        
    var navigationController: UINavigationController
    weak var delegate: OnboardingCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        goToOnboardingVC()
    }
    
    func goToOnboardingVC() {
        let vc = OnboardingViewController.instantiate()
        let vm = OnboardingViewModel()
        vm.coordinatorDelegate = self
        vc.viewModel = vm

        //vc.hidesBottomBarWhenPushed = true
        //navigationController.navigationBar.isTranslucent = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        navigationController.popViewController(animated: true)
        delegate?.didFinish(from: self)
    }

}

extension OnboardingCoordinator: OnboardingViewModelCoordinatorDelegate {

    func didTapAuth() {
        let vc = AuthViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }

    func didTapCityList(completion: ((City) -> Void)?) {
        let vc = CityListViewController.instantiate()
        vc.viewModel = CityListViewModel()
        vc.chooseCompletion = completion
        navigationController.pushViewController(vc, animated: true)
    }

    func didFinish(returnValue: String) {
        finish()
    }

}

protocol OnboardingCoordinatorDelegate: class {
    func didFinish(from coordinator: OnboardingCoordinator)
}
