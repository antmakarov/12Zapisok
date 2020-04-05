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
}
