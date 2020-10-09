//
//  Coordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 17.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    // All application coordinators
    var childCoordinators: [Coordinator] { get set }
    
    // Start a specific coordinator
    func start()
}
