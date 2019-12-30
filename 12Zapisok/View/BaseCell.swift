//
//  BaseCell.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class BaseCardCell: UICollectionViewCell {

    func createCard(backView: UIView) {
        
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 10
        backView.layer.borderColor = UIColor.clear.cgColor
        backView.layer.masksToBounds = true
        
        backgroundColor = UIColor.clear
        layer.shadowOpacity = 0.18
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
}
