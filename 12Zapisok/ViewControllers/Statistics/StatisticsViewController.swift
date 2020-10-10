//
//  StatisticsViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum StatisticsSections {
    case header
    case title
    case city
}

final class StatisticsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: StatisticsViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: StatisticsHeaderCell.self)
        tableView.register(cellType: StatisticsLabelCell.self)
        tableView.register(cellType: StatisticsCell.self)
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
}

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sectionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            fatalError("viewModel is nil")
        }
        
        var cell: UITableViewCell
        switch viewModel.getSection(at: indexPath.row) {
        case .header:
            let newCell = tableView.dequeueReusableCell(with: StatisticsHeaderCell.self, for: indexPath)
            newCell.configure()
            cell = newCell
            
        case .title:
            cell = tableView.dequeueReusableCell(with: StatisticsLabelCell.self, for: indexPath)

        case .city:
            let newCell = tableView.dequeueReusableCell(with: StatisticsCell.self, for: indexPath)
            newCell.configure()
            cell = newCell
        }
        
        return cell
    }
}
