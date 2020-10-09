//
//  CityCollectionCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable final_class

import UIKit

class CityCollectionCell: UICollectionViewCell {

    private enum Constants {
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor: UIColor = .black
    }
    
    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var progressLabel: UILabel!
    @IBOutlet private weak var mainVIew: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(name: String, url: String, score: Int) {
        nameLabel.text = name
        
        cityImageView.rounded(cornerRadius: 6.0)
        cityImageView.setupImage(url: url, placeholder: .city)

        mainVIew.rounded(cornerRadius: 6.0)
        mainVIew.addShadow(opacity: Constants.shadowOpacity,
                           offset: Constants.shadowOffset,
                           radius: Constants.shadowRadius,
                           color: Constants.shadowColor)
    }
}
