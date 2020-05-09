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
    
    var viewModel: GameRulesViewModeling?
    
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
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        return viewModel.rulesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        let cell = tableView.dequeueReusableCell(with: GameRuleCell.self, for: indexPath)
        cell.configure(rule: viewModel.getRule(at: indexPath.row))
        return cell
    }
}
