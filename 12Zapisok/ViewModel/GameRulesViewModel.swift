//
//  GameRulesViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

protocol GameRulesViewModeling: class {
    var closeButtonPressed: (() -> Void)? { get set }
    
    func rulesCount() -> Int
    func getRule(at index: Int) -> GameRule
}

class GameRulesViewModel {
    public var closeButtonPressed: (() -> Void)?
    
    let rules = [GameRule(title: "Основное правило", description: "Игрок получает записку №1, в которой зашифровано место, где находится следующая записка. Всего их 12 штук, чтобы найти следующую, необходимо расшифровать предыдущую. Это старая игра, ставшая прототипом популярных квестов.", color: .appColor),
                 GameRule(title: "Правило 2", description: "В конце игры 12 записка обычно указывает, где спрятан приз – подарки или сладости.", color: .orangeColor),
                 GameRule(title: "И еще:", description: "Виды заданий в записке: загадки, ребусы, пазлы, шифры, чернила симпатические (проявляющие под воздействием определенного вещества или нагревания), диктант графический, кроссворд, анаграммы.", color: .greenColor),
                 GameRule(title: "И напоследок", description: "Играть можно: на природе, в офисе, в музее и кафе, по городу, дома.", color: .appColor)
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
