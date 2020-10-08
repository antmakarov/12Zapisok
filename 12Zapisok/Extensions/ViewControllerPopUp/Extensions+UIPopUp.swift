//
//  Extensions+UIVCPopUp.swift
//  12Zapisok
//
//  Created by Anton Makarov on 05.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import SwiftEntryKit

typealias ButtonHandler = (() -> Void)

enum PopUpType {
    case commonPopUp(title: String, description: String? = nil, image: String? = nil, fButton: String? = nil, sButton: String? = nil, fHandler: ButtonHandler? = nil, sHandler: ButtonHandler? = nil)
    case hint((HintViewHandler) -> Void)
    case openNote
    case manualCoordinates
    case checkDistance
}

extension UIViewController {
    func showPopUp(type: PopUpType) {
        switch type {
        case let .commonPopUp(title, description, image, fButton, sButton, fHandler, sHandler):
            let popUp = PopUpView()
            popUp.configure(title: title, description: description, image: image, firstButtonText: fButton, secondButtonText: sButton, firstButtonHandler: fHandler, secondButtonHandler: sHandler)
            SwiftEntryKit.display(entry: popUp, using: appearAttributes())

        case .hint(let handler):
            let hintView = HintView()
            hintView.configure(newTitle: "Test", type: handler)
            SwiftEntryKit.display(entry: hintView, using: appearAttributes())
            
        case .openNote:
            SwiftEntryKit.display(entry: OpenNoteView(), using: appearAttributes())

        case .manualCoordinates:
            SwiftEntryKit.display(entry: ManualInputView(), using: appearAttributes())
            
        case .checkDistance:
            SwiftEntryKit.display(entry: DistanceToPlaceView(), using: appearAttributes())
        }
    }
    
    func dismissPopUp() {
        SwiftEntryKit.dismiss()
    }
}
