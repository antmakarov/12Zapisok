//
//  StatisticsHeaderCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class StatisticsHeaderCell: BaseTableShadowCell {

    @IBOutlet private weak var totalScore: UILabel!
    @IBOutlet private weak var openNotes: UILabel!
    @IBOutlet private weak var totalAttempts: UILabel!
    @IBOutlet private weak var levelName: UILabel!
    @IBOutlet private weak var sheetView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedWithShadow(backView: sheetView)
    }
    
    func configure(_ total: Int, _ notes: Int, _ attemps: Int) {
        totalScore.text = "\(total)"
        openNotes.text = "\(notes)"
        totalAttempts.text = "\(attemps)"
        
        // TODO: Based on stats
        levelName.text = "Начальный"
    }
}
