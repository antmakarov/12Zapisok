//
//  DistancePointView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 11.05.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class DistancePointView: UIView, NibInstance {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        instantiateFromNib()
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
