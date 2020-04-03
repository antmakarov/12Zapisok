//
//  OnboardingCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var deniedButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var viewModel: OnboardingStepViewModeling?
    private var actionCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        actionButton.layer.cornerRadius = 12
        actionButton.layer.shadowOpacity = 0.18
        actionButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        actionButton.layer.shadowRadius = 5
        actionButton.layer.shadowColor = UIColor.black.cgColor
        deniedButton.isHidden = true
    }
    
    public func configure(with viewModel: OnboardingStepViewModeling, actionCompletion: @escaping () -> Void) {
        
        self.viewModel = viewModel
        self.actionCompletion = actionCompletion

        if viewModel.isNeedAnswerButtons() {
            deniedButton.isHidden = false
            actionButton.setTitle("Да", for: .normal)
            deniedButton.setTitle("Нет", for: .normal)
        } else {
            actionButton.setTitle(viewModel.actionTitle(), for: .normal)
        }
        
        titleLabel.text = viewModel.title()
        detailsLabel.text = viewModel.details()
        skipButton.isHidden = viewModel.isHideSkipButton()
    }
    
    public func startUpdating(newDescription: String) {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        detailsLabel.text = newDescription
    }
    
    @IBAction private func performAction() {
        viewModel?.performAction(action: .done, actionCompletion: actionCompletion)
    }
    
    @IBAction private func deniedAction() {
        viewModel?.performAction(action: .denied, actionCompletion: actionCompletion)
    }
    
    @IBAction func skipAction(_ sender: Any) {
        viewModel?.performAction(action: .skip, actionCompletion: actionCompletion)
    }
}
