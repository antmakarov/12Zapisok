//
//  PopUpView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class PopUpView: BaseView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!

    private var firstButtonHandler: (() -> Void)?
    private var secondButtonHandler: (() -> Void)?

    func configure(title: String,
                   description: String? = nil,
                   image: String? = nil,
                   firstButtonText: String? = nil,
                   secondButtonText: String? = nil,
                   firstButtonHandler: (() -> Void)? = nil,
                   secondButtonHandler: (() -> Void)? = nil) {
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        firstButton.isHidden = firstButtonText == nil
        secondButton.isHidden = secondButtonText == nil

        firstButton.setTitle(firstButtonText)
        secondButton.setTitle(secondButtonText)

        self.firstButtonHandler = firstButtonHandler
        self.secondButtonHandler = secondButtonHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        instantiateFromNib()
        setup()
    }
    
    @IBAction private func firstButtonTap(_ esnder: Any) {
        firstButtonHandler?()
    }
    
    @IBAction private func secondButtonTap(_ esnder: Any) {
        secondButtonHandler?()
    }
}
