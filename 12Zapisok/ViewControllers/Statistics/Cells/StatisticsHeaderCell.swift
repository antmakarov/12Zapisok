//
//  StatisticsHeaderCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

extension NSAttributedString.Key {
    
}
final class StatisticsHeaderCell: BaseTableShadowCell {

    @IBOutlet private weak var totalScore: UILabel!
    @IBOutlet private weak var completedNotes: UILabel!
    @IBOutlet private weak var totalAttempts: UILabel!
    @IBOutlet private weak var levelName: UILabel!
    @IBOutlet private weak var sheetView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedWithShadow(backView: sheetView)
    }
    
    func configure(_ total: Int, _ notes: Int, _ attemps: Int) {
        totalScore.attributedText = prepareLabels(Localized.totalScores, value: total)
        completedNotes.attributedText = prepareLabels(Localized.totalNotes, value: notes)
        totalAttempts.attributedText = prepareLabels(Localized.totalAttempts, value: attemps)
        
        // TODO: Based on stats
        levelName.text = Localized.levelBeginner
    }
    
    private func prepareLabels(_ text: String, value: Int) -> NSAttributedString {
        return text.applyAttributes(.regular(size: 15),
            subString: "\(value)",
            subAttributes: .bold(size: 17))
    }
}
