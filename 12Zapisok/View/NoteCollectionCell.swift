//
//  NoteCollectionCell.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class NoteCollectionCell: BaseCardCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCard(backView: backView)
    }
    
    func configure(viewModel: NoteCollectionCellViewModeling) {
        headerLabel.text = "Записка #\(viewModel.id)"
        
        switch viewModel.state {
        case .open:
            imageView.setupImage(url: viewModel.imgUrl, placeholder: .note)
            statusLabel.text = "Открыта сегодня в 11:45"
            
        case .progress:
            imageView.image = UIImage(named: "1")
            statusLabel.text = "В процессе"
            
        case .close:
            imageView.image = UIImage(named: "2")
            statusLabel.text = "Не открыта"
            statusLabel.alpha = 0.6
        }
    }
}
