//
//  Extensions+UIImageView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 24.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import Kingfisher

enum ImagePlaceholder: String {
    case defaultImg = "PurpleRec"
    case city = "cityPlaceholder"
    case note = "notePlaceholder"
}

extension UIImageView {
    
    func setupImage(url: String, placeholder: ImagePlaceholder = .defaultImg) {
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(
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

