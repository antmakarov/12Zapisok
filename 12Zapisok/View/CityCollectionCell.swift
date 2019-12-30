//
//  CityCollectionCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        nameLabel.text = "Ni No"
    }

}
