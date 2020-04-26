//
//  CityCollectionCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityCollectionCell: UICollectionViewCell {

    private enum Constants {
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor: UIColor = .black
    }
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var mainVIew: UIView!
    
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
