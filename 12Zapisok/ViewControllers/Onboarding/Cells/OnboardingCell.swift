//
//  OnboardingCell.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    private enum Constants {
        static let buttonRadius: CGFloat = 12.0
        static let shadowOffset = CGSize(width: 2, height: 2)
        static let shadowRadius: CGFloat = 5.0
        static let shadowOpacity: Float = 0.18
        
        static let yesTitle = "Да"
        static let noTitle = "Нет"
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var deniedButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private var viewModel: OnboardingStepViewModeling?
    private var actionCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareButton(actionButton)
        prepareButton(deniedButton, isHidden: true)
    }
    
    private func prepareButton(_ button: UIButton, isHidden: Bool = false) {
        button.layer.cornerRadius = Constants.buttonRadius
        button.layer.shadowOffset = Constants.shadowOffset
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOpacity = Constants.shadowOpacity
        button.layer.shadowColor = UIColor.black.cgColor
        button.isHidden = isHidden
    }
    
    public func configure(with viewModel: OnboardingStepViewModeling, actionCompletion: @escaping () -> Void) {
        
        self.viewModel = viewModel
        self.actionCompletion = actionCompletion

        if viewModel.isNeedAnswerButtons() {
            deniedButton.isHidden = false
            actionButton.setTitle(Constants.yesTitle)
            deniedButton.setTitle(Constants.noTitle)
        } else {
            actionButton.setTitle(viewModel.actionTitle(), for: .normal)
        }
        
        cellImage.image = UIImage(named: viewModel.image())
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
    
    @IBAction private func skipAction(_ sender: Any) {
        viewModel?.performAction(action: .skip, actionCompletion: actionCompletion)
    }
}
