//
//  EmptyView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum EmptyViewState {
    case empty
    case error
}

enum EmptyViewType {
    case statistics
    case leaderboard
    case cityList
    case game
    case other(String)
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
    private var viewType: EmptyViewType = .other(Localized.stillEmpty)
    
    private var mainTitle = String.empty
    private var errorTitle = Localized.somethingWrong
    
    private var mainIcon = Asset.Icons.stop.image
    private var errorIcon = Asset.Icons.stop.image

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    // MARK: Configurate
    
    public func configureWith(type: EmptyViewType, repeate: Button?, action: Button?) {
        viewType = type
        
        configureButton(repeateButton, repeate)
        configureButton(actionButton, action)
        
        repeateHandler = repeate?.tapHandler
        actionHandler = action?.tapHandler
        
        switch type {
        case .statistics:
            mainTitle = Localized.emptyStatsMain
            errorTitle = Localized.emptyStatsError
            mainIcon = Asset.Icons.AppIcons.emptyStatistics.image
            errorIcon = Asset.Icons.AppIcons.emptyStatistics.image
            
        case .leaderboard:
            mainTitle = Localized.emptyLeadMain
            errorTitle = Localized.emptyLeadError
            mainIcon = Asset.Icons.leaderboard.image
            errorIcon = Asset.Icons.leaderboard.image
            
        case .cityList:
            mainTitle = Localized.emptyCityMain
            errorTitle = Localized.emptyCityError
            mainIcon = Asset.Icons.AppIcons.route2.image
            errorIcon = Asset.Icons.AppIcons.route2.image
            
        case .game:
            mainTitle = Localized.emptyGameMain
            errorTitle = Localized.emptyGameError
            mainIcon = Asset.Icons.AppIcons.cityscape.image
            errorIcon = Asset.Icons.AppIcons.cityscape.image
            
        case let .other(title):
            mainTitle = title
            errorTitle = Localized.somethingWrong
        }
    }
    
    public func configure(title: String,
                          image: UIImage? = nil,
                          repeate: Button? = nil,
                          action: Button? = nil) {
        
        configureButton(repeateButton, repeate)
        configureButton(actionButton, action)
        
        repeateHandler = repeate?.tapHandler
        actionHandler = action?.tapHandler
        
        mainTitle = title
        mainIcon = image ?? Asset.Icons.appLogo.image
    }
    
    public func updateView(type: EmptyViewState) {
        switch type {
        case .empty:
            actionButton.isHidden = false
            repeateButton.isHidden = true
            titleLabel.text = mainTitle
            imageView.image = mainIcon
            
        case .error:
            actionButton.isHidden = true
            repeateButton.isHidden = false
            titleLabel.text = errorTitle
            imageView.image = errorIcon
        }
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
