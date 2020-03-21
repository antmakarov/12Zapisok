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
    
    init(_ isSuccessAuth: Bool) {
        self = isSuccessAuth ? .main : .onboarding
    }
}

//MARK: Start apllication flow coordinator

class AppCoordinator: BaseCoordinator {
    
    // MARK: Properties, Managers
    
    private let window: UIWindow?
    private let networkManager: NetworkManaging
    private let userPreferences: PreferencesManager

    private lazy var rootViewController: UINavigationController = {
        let nc = UINavigationController()
        nc.navigationBar.isTranslucent = false
        nc.isNavigationBarHidden = true
        return nc
    }()

    init(window: UIWindow?) {
        self.window = window
        self.networkManager = NetworkManager.shared
        self.userPreferences = PreferencesManager()

        super.init()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    override func start() {
        networkManager.updateTokenIfNeeded(isForced: false)
        
        switch ApplicationFlow(userPreferences.isSuccessAuth) {
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
