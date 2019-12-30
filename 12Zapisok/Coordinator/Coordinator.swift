//
//  Coordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class BaseCoordinator {

    private var childCoordinators: [BaseCoordinator] = []

    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

}

extension BaseCoordinator: Equatable {

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }

}

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
