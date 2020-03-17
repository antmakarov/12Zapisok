//
//  GameCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 17.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

protocol GameViewModelCoordinatorDelegate: class {
    func prepareRouting(for route: HomeRoute)
    func showGameNote(noteVM: DetailNoteViewModeling)
    func dismiss()
}

class GameCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    //let noteViewModel: DetailNoteViewModeling
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = GameViewController()
        vc.viewModel = GameViewModel(cityName: "cityName")
        navigationController.pushViewController(vc, animated: true)
    }
}
