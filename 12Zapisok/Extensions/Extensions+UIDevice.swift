//
//  Extensions+UIDevice.swift
//  12Zapisok
//
//  Created by Anton Makarov on 01.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable numbers_smell

import UIKit

extension UIDevice {
    
    enum ScreenType: String {
        case iPhoneSE
        case iPhone6_7_8
        case iPhone6_7_8Plus
        case iPhoneX
        case Other
    }
    
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE
            
        case 1334:
            return .iPhone6_7_8
            
        case 2208, 1920:
            return .iPhone6_7_8Plus
            
        case 2436:
            return .iPhoneX
            
        default:
            return .Other
        }
    }
}
