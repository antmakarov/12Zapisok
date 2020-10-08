//
//  Extensions+UIButton.swift
//  12Zapisok
//
//  Created by Anton Makarov on 05.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func setTitle(_ text: String?, state: UIControl.State = .normal) {
        setTitle(text, for: .normal)
    }
    
    public func setBackground(_ image: UIImage?, state: UIControl.State = .normal) {
        setBackgroundImage(image, for: .normal)
    }
    
    public func setBackground(_ imageName: String?, state: UIControl.State = .normal) {
        if let imageName = imageName, let image = UIImage(named: imageName) {
            setBackgroundImage(image, for: .normal)
        } else {
            setBackgroundImage(nil, for: .normal)
        }
    }
}
