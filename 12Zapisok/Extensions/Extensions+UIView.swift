//
//  Extensions+UIView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 26.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

// MARK: Class Name Identifier

public protocol ClassName {
    static var className: String { get }
}

public extension ClassName {
    static var className: String {
        return String(describing: self)
    }
}

extension UIViewController: ClassName { }
extension UIView: ClassName { }

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
    
    func addGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
