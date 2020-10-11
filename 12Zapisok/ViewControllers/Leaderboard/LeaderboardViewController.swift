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

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
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
