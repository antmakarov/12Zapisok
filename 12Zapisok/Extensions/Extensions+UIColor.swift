//
//  Extensions+UIColor.swift
//  12Zapisok
//
//  Created by Anton Makarov on 06.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var mauve: UIColor {
        return UIColor(hex: 0x6E5D95)
    }
    
    class var appColor: UIColor {
        return UIColor(hex: 0x5A6095)
    }
    
    class var orangeColor: UIColor {
        return UIColor(hex: 0xFF8060)
    }
     
    class var greenColor: UIColor {
        return UIColor(hex: 0x66DD66)
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a)
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
