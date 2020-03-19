//
//  GameCoordinator.swift
//  12Zapisok
//
//  Created by Anton Makarov on 17.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

protocol GameViewModelCoordinatorDelegate: PreviousCoordinator {
    func showGameNote(noteViewModel: GameNoteViewModeling)
}

class GameCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = GameViewController()
        let vm = GameViewModel(cityName: "cityName")
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
}

extension GameCoordinator: GameViewModelCoordinatorDelegate {
    
    func showGameNote(noteViewModel: GameNoteViewModeling) {
        let gameNote = GameNoteViewController()
        gameNote.viewModel = noteViewModel
        navigationController.pushViewController(gameNote, animated: true)
    }
        
    func navigateToPrevious() {
         finishFlow?()
     }
}
