//
//  ErrorView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class ErrorView: UIView, NibInstance {

    private enum Constants {
        static let defaultTitle = "Кажется, что-то пошло не так..."
    }
    
    // MARK: Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var repeateButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!

    private var repeateHandler: (() -> Void)?
    private var backHandler: (() -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    // MARK: Configurate
    
    public func configure(needRepeateButton: Bool = true,
                   needBackButton: Bool = true,
                   title: String? = Constants.defaultTitle,
                   image: String = .empty) {
        repeateButton.isHidden = !needRepeateButton
        backButton.isHidden = !needBackButton
        titleLabel.text = title
    }
    
    public func configureHandler(repeate: (() -> Void)? = nil, back: (() -> Void)? = nil) {
        repeateHandler = repeate
        backHandler = back
    }
    
    // MARK: Actions
    
    @IBAction private func pressRepeate(_ sender: Any) {
        repeateHandler?()
    }
    
    @IBAction private func pressBack(_ sender: Any) {
        backHandler?()
    }
}
