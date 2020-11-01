//
//  NoteCollectionCell.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class NoteCollectionCell: BaseCardCell {

    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCard(backView: backView)
    }
    
    func configure(viewModel: NoteCollectionCellViewModeling) {
        
        headerLabel.text = Localized.noteNumber(String(viewModel.id))
        imageView.addBorder(width: 1, color: .white)
        
        switch viewModel.state {
        case .open:
            imageView.rounded(cornerRadius: 8)
            imageView.setupImage(url: viewModel.imgUrl, placeholder: .note)
            backView.backgroundColor = .AppMainDark
            statusLabel.text = viewModel.title
            
            statusLabel.textColor = .white
            
        case .progress:
            imageView.rounded(cornerRadius: 8)
            imageView.image = Asset.Icons.progressIcon.image
            backView.backgroundColor = .AppOrange
            statusLabel.text = viewModel.title
            statusLabel.textColor = .white

        case .close:
            imageView.rounded(cornerRadius: 8)
            imageView.image = Asset.Icons.unavailableIcon.image
            backView.backgroundColor = .AppGray
            statusLabel.text = Localized.notAvailable
            statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            headerLabel.textColor = UIColor(hex: 0x252626)
            statusLabel.textColor = UIColor(hex: 0x252626)
        }
    }
}
