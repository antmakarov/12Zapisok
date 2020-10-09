//
//  BaseCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

// MARK: Base Root Coordinator

public class BaseCoordinator: Coordinator {

    internal var childCoordinators: [Coordinator] = []
    var finishFlow: (() -> Void)?

    // MARK: Public override methods
    
    public func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    // MARK: Final methods

    final func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    final func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    final func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }

    final func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: BaseCoordinator Equatable

extension BaseCoordinator: Equatable {
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
