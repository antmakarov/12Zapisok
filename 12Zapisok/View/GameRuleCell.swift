//
//  GameRuleCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

struct GameRule {
    var title: String
    var description: String
    var color: UIColor
}

class GameRuleCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dottedLayer: UIView!
    
    func configure(rule: GameRule) {
        titleLabel.text = rule.title
        descriptionLabel.text = rule.description
        
        titleLabel.textColor = rule.color
        drawDottedLine(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: dottedLayer.frame.height), view: dottedLayer)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = titleLabel.textColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    override func prepareForReuse() {
        titleLabel.text?.removeAll()
        descriptionLabel.text?.removeAll()
        dottedLayer.layer.sublayers = nil
    }
}
