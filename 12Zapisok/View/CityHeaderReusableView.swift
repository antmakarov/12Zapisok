//
//  CityHeaderReusableView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImage.addShadow()
        cityImage.layer.cornerRadius = cityImage.frame.height / 2
        mainView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 25.0)
        mainView.addShadow()
    }
    
    public func configure(name: String, imageUrl: String) {
        cityName.text = name
        
        if let url = URL(string: imageUrl) {
            cityImage.kf.setImage(with: url)
        }
    }
}
