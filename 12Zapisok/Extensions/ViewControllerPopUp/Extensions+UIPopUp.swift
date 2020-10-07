//
//  Extensions+UIVCPopUp.swift
//  12Zapisok
//
//  Created by Anton Makarov on 05.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import SwiftEntryKit

enum PopUpType {
    case text
    case textWithButton
    case textWithButtons
    case hint((HintViewHandler) -> Void)
    case openNote
    case manualCoordinates
    case checkDistance
}

extension UIViewController {
    func showPopUp(type: PopUpType) {
        switch type {
        case .text:
            SwiftEntryKit.display(entry: ManualInputView(), using: appearAttributes())
            
        case .textWithButton:
            SwiftEntryKit.display(entry: ManualInputView(), using: appearAttributes())
            
        case .textWithButtons:
            SwiftEntryKit.display(entry: ManualInputView(), using: appearAttributes())
            
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
