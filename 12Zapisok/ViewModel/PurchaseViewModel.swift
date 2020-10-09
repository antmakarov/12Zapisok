//
//  PurchaseViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

protocol PurchaseViewModeling: AnyObject {
    func buyHint(type: HintType)

    var closeButtonPressed: (() -> Void)? { get set }
}

final class PurchaseViewModel {
    
    public var closeButtonPressed: (() -> Void)?

    private let hintManager: HintManaging
    
    init(hintManager: HintManaging = HintManager.shared) {
        self.hintManager = hintManager
    }
}

extension PurchaseViewModel: PurchaseViewModeling {
    public func buyHint(type: HintType) {
        hintManager.updateHint(type: type, operation: .add)
    }
}
