//
//  EmptyView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class EmptyView: UIView, NibInstance {

    private enum Constants {
        static let defaultTitle = Localized.somethingWrong
    }
    
    // MARK: Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var actionButton: UIButton!

    private var actionHandler: (() -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    // MARK: Configurate
    
    public func configure(needActionButton: Bool = true,
                          title: String? = Constants.defaultTitle,
                          image: String = .empty,
                          action: (() -> Void)? = nil) {
        actionButton.isHidden = !needActionButton
        titleLabel.text = title
        actionHandler = action
    }
    
    // MARK: Actions
    
    @IBAction private func tapActionButton(_ sender: Any) {
        actionHandler?()
    }
}
