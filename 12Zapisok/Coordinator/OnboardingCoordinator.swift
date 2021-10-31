//
//  OnboardingCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import SwiftUI

enum OnboardingRoute {
    case auth
    case cityList(completion: ((City) -> Void)?)
    case back
}

final class OnboardingCoordinator: BaseCoordinator {
        
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = OnboardingViewController()
        let vm = OnboardingViewModel()
        vm.routeTo = { route in
            self.manageRoute(route)
        }
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }

    private func manageRoute(_ route: OnboardingRoute) {
        switch route {
        case .auth:
            let vc = LoginViewController()
            navigationController.pushViewController(vc, animated: true)
            
        case .cityList(let completion):
            let vm = CityListViewModel(isOnboarding: true)
            let vc = UIHostingController(rootView: CityListView(viewModel: vm)) //Controller()

            vm.closeButtonPressed = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
           // vc.chooseCompletion = completion
            navigationController.pushViewController(vc, animated: true)
            
        case .back:
            finishFlow?()
        }
    }
}
