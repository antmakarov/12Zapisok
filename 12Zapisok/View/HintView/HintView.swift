//
//  HintView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 06.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum HintViewHandler {
    case apply
    case buy
    case showAd
    case close
}

final class HintView: BaseView {

    @IBOutlet private weak var title: UILabel!
    
    private var completionType: ((HintViewHandler) -> Void)?

    func configure(newTitle: String, type: ((HintViewHandler) -> Void)?) {
        title.text = newTitle
        completionType = type
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
    
    @IBAction private func applyHint(_ esnder: Any) {
        completionType?(.apply)
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
