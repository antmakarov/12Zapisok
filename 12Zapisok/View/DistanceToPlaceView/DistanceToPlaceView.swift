//
//  DistanceToPlaceView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 11.05.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class DistanceToPlaceView: BaseView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        instantiateFromNib()
        setup()
    }
}
