//
//  LeaderboardViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class LeaderboardViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: EmptyView!

    var viewModel: LeaderboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        viewModel?.fetchLeaders()
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
        emptyView.configureWith(type: .leaderboard,
                                repeate: Button(title: Localized.repeate) { [weak self] in
                                    self?.viewModel?.fetchLeaders()
                                },
                                action: Button(title: Localized.startGame) { [weak self] in
                                    self?.viewModel?.routeTo?(.game)
                                })
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.routeTo?(.back)
    }
}

extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.usersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
