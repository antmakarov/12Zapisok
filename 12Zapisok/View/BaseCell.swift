//
//  BaseCell.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class BaseCardCell: UICollectionViewCell {

    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let borderWidth: CGFloat = 1.0
        static let borderColor = UIColor.clear.cgColor

        static let shadowOpacity: Float = 0.18
        static let shadowRadius: CGFloat = 5.0
        static let shadowColor = UIColor.black.cgColor
        static let shadowOffset = CGSize(width: 2, height: 2)
    }

    func createCard(backView: UIView) {
        backView.layer.borderWidth = Constants.borderWidth
        backView.layer.cornerRadius = Constants.cornerRadius
        backView.layer.borderColor = Constants.borderColor
        backView.layer.masksToBounds = true
        
        backgroundColor = UIColor.clear
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowColor = Constants.shadowColor
        layer.masksToBounds = false
    }
}
