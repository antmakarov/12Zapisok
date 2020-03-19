//
//  AppCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

//MARK: Launch Instructor

fileprivate enum ApplicationFlow {
    case main
    case onboarding
    
    static func choose(_ isSuccessAuth: Bool) -> ApplicationFlow {
        return isSuccessAuth ? .main : .onboarding
    }
}

//MARK: Start apllication flow coordinator

class AppCoordinator: BaseCoordinator {
    
    // MARK: Properties
    
    private let window: UIWindow?
    private let preferencesManager: PreferencesManager
    
    private lazy var rootViewController: UINavigationController = {
        let nc = UINavigationController()
        nc.navigationBar.isTranslucent = false
        nc.isNavigationBarHidden = true
        return nc
    }()

    init(window: UIWindow?) {
        self.window = window
        self.preferencesManager = PreferencesManager()

        super.init()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    override func start() {
        switch ApplicationFlow.choose(preferencesManager.isSuccessAuth) {
        case .onboarding:
            runOnboardingFlow()
        
        case .main:
            runHomeFlow()
        }
    }
    
    // MARK: Private run flow methods
    
    private func runOnboardingFlow() {
        let coordinator = OnboardingCoordinator(navigationController: rootViewController)
        coordinator.finishFlow = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeChildCoordinator(coordinator)
            strongSelf.runHomeFlow()
        }
        
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func runHomeFlow() {
        let coordinator = HomeCoordinator(navigationController: rootViewController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
