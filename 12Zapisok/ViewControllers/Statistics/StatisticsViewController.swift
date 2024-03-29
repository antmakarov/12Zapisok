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

    var viewModel: StatisticsViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        viewModel?.fetchStatistics()
    }

    private func bindViewModel() {
        viewModel?.isLoading.addObserver { [weak self] in
            self?.toggleLoader($0)
        }

        viewModel?.dataType.addObserver { [weak self] type in
            switch type {
            case .success:
                self?.emptyView.isHidden = true
                self?.tableView.reloadData()

            case .error:
                self?.emptyView.isHidden = false
                self?.emptyView.updateView(type: .error)

            case .empty:
                self?.emptyView.isHidden = false
                self?.emptyView.updateView(type: .empty)
            }
        }
    }

    private func configureUI() {
        emptyView.configureWith(type: .statistics,
                                repeate: Button(title: Localized.repeate) { [weak self] in
                                    self?.viewModel?.fetchStatistics()
                                },
                                action: Button(title: Localized.startGame) { [weak self] in
                                    self?.viewModel?.routeTo?(.game)
                                })
        
        tableView.register(cellType: StatisticsHeaderCell.self)
        tableView.register(cellType: StatisticsLabelCell.self)
        tableView.register(cellType: StatisticsCell.self)
    }
    
    @IBAction private func aboutPointButtonPressed(_ sender: Any) {
        Logger.mark()
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
            newCell.configure(total, notes, attemps) {
                Logger.mark()
            }
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
