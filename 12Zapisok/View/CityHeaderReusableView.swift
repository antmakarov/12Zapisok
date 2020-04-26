//
//  CityHeaderReusableView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityHeaderReusableView: UICollectionReusableView {

    private enum Constants {
        static let borderWidth: CGFloat = 3.0
        static let borderColor: UIColor = .mauve
    }
    
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImage.rounded()
        cityImage.addBorder(width: Constants.borderWidth, color: Constants.borderColor)
    }
    
    public func configure(name: String, imageUrl: String) {
        cityName.text = name
        cityImage.setupImage(url: imageUrl, placeholder: .city)
    }
}
