//
//  Extensions+UIView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 26.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

// MARK: Class Name Identifier

public protocol ClassNameProtocol {
    static var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
}

extension UIViewController: ClassNameProtocol { }
extension UIView: ClassNameProtocol { }

// MARK: Custom UI

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.black.cgColor
    }
}
