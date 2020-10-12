//
//  BuyHintView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 06.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum HintViewHandler {
    case buy
    case showAd
    case close
}

final class BuyHintView: BaseView {

    private enum Constants {
        static let viewHeight: CGFloat = 340.0
    }
    
    @IBOutlet private weak var title: UILabel!
    
    private var completionType: ((HintViewHandler) -> Void)?

    func configure(type: ((HintViewHandler) -> Void)?) {
        completionType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
        setup(height: Constants.viewHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        instantiateFromNib()
        setup(height: Constants.viewHeight)
    }
    
    @IBAction private func buyHint(_ esnder: Any) {
        completionType?(.buy)
    }
    
    @IBAction private func showAd(_ esnder: Any) {
        completionType?(.showAd)
    }
    
    @IBAction private func close(_ esnder: Any) {
        completionType?(.close)
    }
}
