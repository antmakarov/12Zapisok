//
//  LeaderboardViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    var viewModel: LeaderboardViewModeling? {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
}
