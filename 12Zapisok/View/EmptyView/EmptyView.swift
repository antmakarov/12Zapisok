//
//  EmptyView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum EmptyViewType {
    case empty
    case error
    case networkError
}

struct Button {
    var title: String
    var tapHandler: (() -> Void)?
}

final class EmptyView: UIView, NibInstance {

    private enum Constants {
        static let defaultTitle = Localized.somethingWrong
    }
    
    // MARK: Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var repeateButton: UIButton!
    @IBOutlet private weak var actionButton: UIButton!

    private var repeateHandler: (() -> Void)?
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
    
    public func configure(type: EmptyViewType? = .empty,
                          title: String? = Constants.defaultTitle,
                          image: String = .empty,
                          repeate: Button? = nil,
                          action: Button? = nil) {
        
        configureButton(repeateButton, repeate)
        configureButton(actionButton, action)
        
        repeateHandler = repeate?.tapHandler
        actionHandler = action?.tapHandler
        
        titleLabel.text = title
    }
    
    private func configureButton(_ uiButton: UIButton, _ button: Button?) {
        uiButton.isHidden = button == nil
        uiButton.setTitle(button?.title)
    }
    
    // MARK: Actions
    
    @IBAction private func pressRepeate(_ sender: Any) {
        repeateHandler?()
    }
    
    @IBAction private func pressAction(_ sender: Any) {
        actionHandler?()
    }
}
