//
//  Coordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

//MARK: Base Root Coordinator

public class BaseCoordinator {

    private var childCoordinators: [BaseCoordinator] = []
    
    //MARK: Public override methods
    
    public func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    public func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // no-op
    }
    
    //MARK: Final methods

    final func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    final func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else {
            Logger.error(msg: "Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
            return
        }
        childCoordinators.remove(at: index)
    }

    final func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    final func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

//MARK: BaseCoordinator Equatable

extension BaseCoordinator: Equatable {
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
