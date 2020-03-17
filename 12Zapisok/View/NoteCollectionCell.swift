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
    
    var viewModel: NoteCollectionCellViewModeling? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
           // headerLabel.text = "Записка #\(viewModel.note.id)"
            
//            if viewModel.note.isOpen {
//                imageView.image = UIImage(named: "1")
//                statusLabel.text = "Открыта сегодня в 11:45"
//            } else {
//                imageView.image = UIImage(named: "2")
//                statusLabel.text = "Не открыта"
//                statusLabel.alpha = 0.6
//            }
        }
    }
}
