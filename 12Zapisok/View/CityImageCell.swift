//
//  CityImageCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 28.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class CityImageCell: UICollectionViewCell {

    private enum Constants {
        static let shadowOpacity: Float = 0.1
        static let shadowOffset = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor: UIColor = .black
    }
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.addShadow(opacity: Constants.shadowOpacity,
                           offset: Constants.shadowOffset,
                           radius: Constants.shadowRadius,
                           color: Constants.shadowColor)
    }
}
