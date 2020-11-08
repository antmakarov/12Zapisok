//
//  TriangleView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class TriangleView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()
        
        context.setFillColor(UIColor.white.cgColor)
        context.fillPath()
    }
}
