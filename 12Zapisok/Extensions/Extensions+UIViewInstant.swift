//
//  Extensions+UIViewInstant.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

// MARK: Load view from Nib

extension UIView {
    class func loadFromNib() -> UIView? {
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first as? UIView
    }
}

// MARK: NibInstance - load view through protocol

protocol NibInstance {
    static func instantiate() -> Self?
    func instantiateFromNib()
}

extension NibInstance where Self: UIView {
    static func instantiate() -> Self? {
        Bundle.main.loadNibNamed("\(Self.self)", owner: nil, options: nil)?.first as? Self
    }

    func instantiateFromNib() {
        guard let contentView = Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)?.first as? UIView else {
            return
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constraintToSuperview()
    }
}
