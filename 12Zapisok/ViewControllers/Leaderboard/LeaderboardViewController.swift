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

    var viewModel: LeaderboardViewModeling? {
        didSet {
            viewModel?.isLoading.addObserver { [weak self] in
                self?.emptyView.isHidden = $0
                self?.toggleLoader($0)
            }
            
            viewModel?.responseStatus.addObserver { [weak self] status in
                switch status {
                case .success:
                    self?.tableView.reloadData()
                    self?.emptyView.isHidden = true
                    
                case .error, .networkError:
                    self?.emptyView.isHidden = false
                    self?.emptyView.updateView(type: .error)
                    
                case .empty:
                    self?.emptyView.isHidden = false
                    self?.emptyView.updateView(type: .empty)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel?.fetchLeaders()
    }
    
    private func setupUI() {
        emptyView.configureWith(type: .leaderboard,
                                repeate: Button(title: "Повторить") { [weak self] in
                                    self?.viewModel?.fetchLeaders()
                                },
                                action: Button(title: "Начать") { [weak self] in
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
