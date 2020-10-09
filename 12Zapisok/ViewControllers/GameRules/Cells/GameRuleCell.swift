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

final class GameRuleCell: UITableViewCell {
    
    private enum Constants {
        static let lineWidth: CGFloat = 2.0
        static let pointOffset: CGFloat = 14.0
        static let pointSize: CGFloat = 16.0
        static let pointName = "Point"
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configure(rule: GameRule) {
        titleLabel.text = rule.title
        descriptionLabel.text = rule.description
        
        titleLabel.textColor = rule.color
        drawPoint()
    }
    
    func drawPoint() {
        let xPosition = titleLabel.frame.origin.x - Constants.pointOffset - Constants.pointSize
        let yPosition = titleLabel.frame.origin.y + titleLabel.frame.height / 4
        let point = CGPoint(x: xPosition, y: yPosition)

        let pointSize = CGSize(width: Constants.pointSize, height: Constants.pointSize)
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: point, size: pointSize))
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = titleLabel.textColor.cgColor
        shapeLayer.lineWidth = Constants.lineWidth
        shapeLayer.name = Constants.pointName

        layer.addSublayer(shapeLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text?.removeAll()
        descriptionLabel.text?.removeAll()
        layer.sublayers?.removeAll { $0.name == Constants.pointName }
    }
}
