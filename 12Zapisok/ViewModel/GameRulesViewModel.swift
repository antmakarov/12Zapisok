//
//  GameRulesViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable all

import Foundation

protocol GameRulesViewModeling: AnyObject {
    var closeButtonPressed: (() -> Void)? { get set }
    
    func rulesCount() -> Int
    func getRule(at index: Int) -> GameRule
}

class GameRulesViewModel {
    public var closeButtonPressed: (() -> Void)?
    
    let rules = [GameRule(title: Localized.rulesMain, description: Localized.rulesMainDsc, color: .appColor),
                 GameRule(title: Localized.rulesOne, description: Localized.rulesOneDsc, color: .AppOrange),
                 GameRule(title: Localized.rulesMore, description: Localized.rulesMoreDsc, color: .greenColor),
                 GameRule(title: Localized.rulesLast, description: Localized.rulesLastDsc, color: .appColor)
    ]
}

extension GameRulesViewModel: GameRulesViewModeling {
    public func rulesCount() -> Int {
        return rules.count
    }
    
    public func getRule(at index: Int) -> GameRule {
        return rules[index]
    }
}
