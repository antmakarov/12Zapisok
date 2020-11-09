//
//  Extensions+String.swift
//  12Zapisok
//
//  Created by Anton Makarov on 17.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import Kingfisher

enum NSAttributedStyle {
    case regular(size: CGFloat)
    case bold(size: CGFloat)
    
    var attribute: [NSAttributedString.Key: AnyObject] {
        switch self {
        case let .regular(size):
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular)]

        case let .bold(size):
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .bold)]
        }
    }
}

extension String {
    
    public static let empty = ""
    public static let newLine = "\n"
    public static let space = " "
    
    func applyAttributes(_ attributes: NSAttributedStyle, subString: String, subAttributes: NSAttributedStyle) -> NSMutableAttributedString {
        
        let mutableAttributedString = NSMutableAttributedString()

        let boldAttributedString = NSAttributedString(string: self, attributes: attributes.attribute )
        let regularAttributedString = NSAttributedString(string: subString, attributes: subAttributes.attribute)
        
        mutableAttributedString.append(boldAttributedString)
        mutableAttributedString.append(regularAttributedString)

        return mutableAttributedString
    }
}

// MARK: Download image from url

extension String {
    
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: self) else {
            completion(nil)
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image)

            case .failure:
                completion(nil)
            }
        }
    }
}
