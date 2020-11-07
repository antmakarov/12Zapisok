//
//  BaseView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 09.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class BaseView: UIView, NibInstance {
    
    private enum Constants {
        static let viewHeight: CGFloat = 300.0
        static let viewWidth: CGFloat = 300.0
    }
    
    func setup(height: CGFloat = Constants.viewHeight,
               width: CGFloat = Constants.viewWidth) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
