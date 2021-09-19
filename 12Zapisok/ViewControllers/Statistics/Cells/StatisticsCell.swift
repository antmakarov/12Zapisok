//
//  StatisticsCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class StatisticsCell: BaseTableShadowCell {

    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var cityScore: UILabel!
    @IBOutlet private weak var cityStatistics: UILabel!
    @IBOutlet private weak var sheetView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityImage.rounded()
        roundedWithShadow(backView: sheetView)
    }
    
    func configure(_ stats: CityStatistics) {
        //let url = StorageManager.shared.getObjectByID(City.self, id: stats.id)?.imageUrl
        //cityImage.setupImage(url: url, placeholder: .city)
        
        cityName.text = stats.name
        cityScore.text = "\(stats.totalAttempts)"
        cityStatistics.text = "Найлено 12 записок / \(stats.countAttempts) попыток"
    }
}
