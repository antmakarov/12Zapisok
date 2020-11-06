//
//  BaseTableShadowCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class BaseTableShadowCell: UITableViewCell {

    private enum Constants {
        static let shadowOpacity: Float = 1.0
        static let shadowOffset = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 4
        static let shadowColor = UIColor.black.withAlphaComponent(0.1)
        static let cornerRadius: CGFloat = 6.0
    }
    
    func roundedWithShadow(backView: UIView) {
        backView.rounded(cornerRadius: Constants.cornerRadius)
        
        backgroundColor = UIColor.clear
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowColor = Constants.shadowColor.cgColor
    }
}
