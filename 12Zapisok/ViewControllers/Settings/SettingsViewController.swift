//
//  SettingsViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 16.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    var viewModel: SettingsViewModeling? {
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
