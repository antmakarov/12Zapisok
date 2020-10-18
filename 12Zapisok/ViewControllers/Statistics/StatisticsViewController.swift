//
//  StatisticsViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

enum StatisticsSections {
    case header(total: Int, notes: Int, attemps: Int)
    case title
    case city(stats: CityStatistics)
}

final class StatisticsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: EmptyView!

    var viewModel: StatisticsViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                self?.emptyView.isHidden = self?.viewModel?.sectionsCount() != 0
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        emptyView.configure(title: Localized.notStartedGame) { [weak self] in
            self?.viewModel?.routeTo?(.game)
        }
        tableView.register(cellType: StatisticsHeaderCell.self)
        tableView.register(cellType: StatisticsLabelCell.self)
        tableView.register(cellType: StatisticsCell.self)
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.routeTo?(.back)
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
        case let .header(total, notes, attemps):
            let newCell = tableView.dequeueReusableCell(with: StatisticsHeaderCell.self, for: indexPath)
            newCell.configure(total, notes, attemps)
            cell = newCell
            
        case .title:
            cell = tableView.dequeueReusableCell(with: StatisticsLabelCell.self, for: indexPath)

        case let .city(stats):
            let newCell = tableView.dequeueReusableCell(with: StatisticsCell.self, for: indexPath)
            newCell.configure(stats)
            cell = newCell
        }
        
        return cell
    }
}
