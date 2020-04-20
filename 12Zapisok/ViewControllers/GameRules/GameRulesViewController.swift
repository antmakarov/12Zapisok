//
//  GameRulesViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 16.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class GameRulesViewController: BaseViewController {

    @IBOutlet private weak var rulesTableView: UITableView!
    
    let rules = [GameRule(title: "Основное правило", description: "Игрок получает записку №1, в которой зашифровано место, где находится следующая записка. Всего их 12 штук, чтобы найти следующую, необходимо расшифровать предыдущую. Это старая игра, ставшая прототипом популярных квестов.", color: .blue),
                 GameRule(title: "Правило 2", description: "В конце игры 12 записка обычно указывает, где спрятан приз – подарки или сладости.", color: .red),
                 GameRule(title: "И еще:", description: "Виды заданий в записке: загадки, ребусы, пазлы, шифры, чернила симпатические (проявляющие под воздействием определенного вещества или нагревания), диктант графический, кроссворд, анаграммы.", color: .yellow),
                 GameRule(title: "И напоследок", description: "Играть можно: на природе, в офисе, в музее и кафе, по городу, дома.", color: .green)
    ]
    
    var viewModel: GameRulesViewModeling? {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesTableView.register(cellType: GameRuleCell.self)
    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
}

extension GameRulesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: GameRuleCell.self, for: indexPath)
        cell.configure(rule: rules[indexPath.row])
        return cell
    }
}
