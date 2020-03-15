//
//  AppCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: Properties
    
    private let window: UIWindow?
    private let preferencesManager: PreferencesManager

    private enum ApplicationFlow {
        case onboarding
        case home
    }
    
    private lazy var rootViewController: UINavigationController = {
        let nc = UINavigationController()
        nc.navigationBar.isTranslucent = false
        nc.isNavigationBarHidden = true

        return nc
    }()

    init(window: UIWindow?) {
        self.window = window
        self.preferencesManager = PreferencesManager()
    }
    
    override func start() {
        guard let window = window else {
            return
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        startApplicationFlow()
    }
    
    // MARK: Private star methods

    fileprivate func startApplicationFlow() {
        changeApplicatonFlow(preferencesManager.isSuccessAuth ? .home : .onboarding)
    }
    
    private func changeApplicatonFlow(_ flow: ApplicationFlow) {
        let coordinator: BaseCoordinator
        
        switch flow {
        case .onboarding:
            coordinator = OnboardingCoordinator(navigationController: rootViewController)
            (coordinator as? OnboardingCoordinator)?.delegate = self
            
        case .home:
            coordinator = HomeCoordinator(navigationController: rootViewController)
        }
        
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func didFinishOnboarding(from coordinator: OnboardingCoordinator) {
        rootViewController.dismiss(animated: true, completion: nil)
        removeChildCoordinator(coordinator)
        changeApplicatonFlow(.home)
    }
}
