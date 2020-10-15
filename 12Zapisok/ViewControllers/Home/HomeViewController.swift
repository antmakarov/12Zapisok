//
//  HomeViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 25.0
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor = UIColor.black.cgColor
    }
    
    // MARK: Outlets
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var middleActionsView: UIView!
    @IBOutlet private var circleMenuImages: [UIImageView]!
    @IBOutlet private var menuItemViews: [UIView]!
    
    // MARK: Private / Public variables
    
    public var viewModel: HomeViewModeling? {
        didSet {
            viewModel?.updateCityHandler = {
                self.updateUI()
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    // MARK: Setup UI
    
    private func updateUI() {
        guard let viewModel = viewModel else {
            Logger.error(msg: "No instance ViewModel")
            return
        }
        
        cityNameLabel.text = viewModel.getCurrentCityName()
        cityImage.setupImage(url: viewModel.getCurrentCityImage(), placeholder: .city)
        cityImage.layer.borderWidth = 1.0
        cityImage.layer.borderColor = UIColor.white.cgColor
    }
    
    private func prepareUI() {
        middleActionsView.roundCorners(corners: [.topLeft, .topRight], radius: Constants.cornerRadius)
        menuItemViews.forEach {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMenuItem(sender:)))
            $0.addGestureRecognizer(tapGesture)
        }
        
        circleMenuImages.forEach {
            $0.layer.shadowOpacity = Constants.shadowOpacity
            $0.layer.shadowOffset = Constants.shadowOffset
            $0.layer.shadowRadius = Constants.shadowRadius
            $0.layer.shadowColor = Constants.shadowColor
        }
    }
}

// MARK: Action Handlers

extension HomeViewController {
    
    @IBAction private func openMap(_ sender: Any) {
        viewModel?.routeTo?(.showMap)
    }
    
    @IBAction private func showCityInfo(_ sender: Any) {
        viewModel?.routeTo?(.showCityInfo)
    }
    
    @IBAction private func openStatistics(_ sender: Any) {
        viewModel?.routeTo?(.showStatistics)
    }
    
    @IBAction private func openSettings(_ sender: Any) {
        viewModel?.routeTo?(.showSettings)
    }
    
    @IBAction private func openLeaderBoard(_ sender: Any) {
        viewModel?.routeTo?(.showLeaders)
    }
    
    @objc
    private func tapMenuItem(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            Logger.error(msg: "Unable to get the tag")
            return
        }
        
        switch tag {
        case 1:
            viewModel?.routeTo?(.showGame(cityName: viewModel?.getCurrentCityName() ?? .empty) )
            
        case 2:
            viewModel?.routeTo?(.showCityList)
            
        case 3:
            viewModel?.routeTo?(.showRules)
            
        case 4:
            viewModel?.routeTo?(.showPurchase)
            
        default:
            Logger.info(msg: "Missing tag action")
        }
    }
}
