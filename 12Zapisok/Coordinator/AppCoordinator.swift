//
//  AppCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow?
    
    private lazy var rootViewController: UINavigationController = {
        let nc = UINavigationController()
        nc.navigationBar.isTranslucent = false
        nc.isNavigationBarHidden = true

        return nc
    }()

    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        goToOnboardingOrLoader()
    }
    
    func goToOnboardingOrLoader() {
        switchToOnboardingCoordinator()
    }

    private func switchToHomeScreen() {
        let homeCoordinator = MainCoordinator(navigationController: rootViewController)
        //homeCoordinator.delegate = self
        self.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
    
    private func switchToOnboardingCoordinator() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: rootViewController)
        onboardingCoordinator.delegate = self
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func didFinish(from coordinator: OnboardingCoordinator) {
        rootViewController.dismiss(animated: true, completion: nil)
        removeChildCoordinator(coordinator)
        switchToHomeScreen()
    }
}
