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
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCard(backView: backView)
    }
    
    func configure(viewModel: NoteCollectionCellViewModeling) {
        
        headerLabel.text = "Записка #\(viewModel.id)"
        
        switch viewModel.state {
        case .open:
            imageView.rounded(cornerRadius: 8)
            imageView.setupImage(url: viewModel.imgUrl, placeholder: .note)
            backImageView.image = .successBig
            statusLabel.text = viewModel.title
            openTimeLabel.text = viewModel.openTime
            
            statusLabel.textColor = .white
            openTimeLabel.textColor = .white
            
        case .progress:
            imageView.rounded(cornerRadius: 8)
            imageView.image = .progressIcon
            backImageView.image = .progressBig
            statusLabel.text = viewModel.title
            openTimeLabel.text = "В текущих поисках"
            
            statusLabel.textColor = .white
            openTimeLabel.textColor = .white

        case .close:
            imageView.rounded(cornerRadius: 8)
            imageView.image = .unavailableIcon
            backImageView.image = .unavailableBig
            openTimeLabel.isHidden = true
            statusLabel.text = "Недоступна"
            statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            headerLabel.textColor = UIColor(hex: 0x252626)
            statusLabel.textColor = UIColor(hex: 0x252626)
        }
    }
}