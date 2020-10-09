//
//  Extensions+UIImageView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 24.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import Kingfisher

enum ImagePlaceholder {
    case app, city, note
    
    var image: UIImage {
        switch self {
        case .app:
            return Asset.Icons.appPlaceholder

        case .city:
            return Asset.Icons.cityPlaceholder
            
        case .note:
            return Asset.Icons.appPlaceholder
        }
    }
}

extension UIImageView {
    
    func setupImage(url: String?, placeholder: ImagePlaceholder = .app) {
        if let stringURL = url, let url = URL(string: stringURL) {
            kf.indicatorType = .activity
            kf.setImage(
                with: url,
                placeholder: placeholder.image,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
        }
    }
}
