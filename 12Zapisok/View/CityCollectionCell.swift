//
//  CityCollectionCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import Kingfisher

class CityCollectionCell: UICollectionViewCell {

    private enum Constants {
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor = UIColor.black.cgColor
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
        
        cityImageView.layer.cornerRadius = 6.0
        
        mainVIew.layer.cornerRadius = 6.0
        mainVIew.layer.shadowOpacity = Constants.shadowOpacity
        mainVIew.layer.shadowOffset = Constants.shadowOffset
        mainVIew.layer.shadowRadius = Constants.shadowRadius
        mainVIew.layer.shadowColor = Constants.shadowColor
        
        if let url = URL(string: url) {
            cityImageView.kf.indicatorType = .activity
            cityImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "cityPlaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
        }
    }
}
