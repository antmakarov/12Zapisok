//
//  Extensions+UIViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 31.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum TransitionAction {
    case present
    case dismiss
}

extension UIViewController {
    
    func modalEffect(action: TransitionAction, _ viewController: UIViewController? = nil, type: CATransitionType = .fade, duration: Double = 0.5) {
        let transition = makeTransition(type: type, duration: duration)
        view.window?.layer.add(transition, forKey: kCATransition)

        switch action {
        case .present:
            if let viewController = viewController {
                viewController.modalPresentationStyle = .overCurrentContext
                present(viewController, animated: false, completion: nil)
            }

        case .dismiss:
            dismiss(animated: false, completion: nil)
        }
    }
    
    private func makeTransition(type: CATransitionType, duration: Double) -> CATransition {
        let transition = CATransition()
        transition.duration = duration
        transition.type = type
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return transition
    }
}
