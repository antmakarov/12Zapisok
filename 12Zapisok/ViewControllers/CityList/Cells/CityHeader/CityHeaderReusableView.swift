//
//  CityHeaderReusableView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 30.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class CityHeaderReusableView: UICollectionReusableView {

    private enum Constants {
        static let borderWidth: CGFloat = 3.0
        static let borderColor: UIColor = .mauve
        static let notChoosenCity: String = "Город не выбран"
        static let chooseCity: String = "Выберите один из городов для начала игры"
        static let currentCity: String = "текущий выбранный город"
    }
    
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImage.rounded()
        
    }
    
    public func configure(name: String, imageUrl: String) {
        if name.isEmpty {
            cityName.isHidden = true
            descriptionLabel.text = Constants.chooseCity
        } else {
            cityName.text = name
            descriptionLabel.text = Constants.currentCity
            cityImage.addBorder(width: Constants.borderWidth, color: Constants.borderColor)
        }
        
        cityImage.setupImage(url: imageUrl, placeholder: .city)
    }
}
