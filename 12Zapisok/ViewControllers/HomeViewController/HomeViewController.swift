//
//  HomeViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private enum Constants {
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor = UIColor.black.cgColor
    }
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private var circleMenuImages: [UIImageView]!
    @IBOutlet private var menuItemViews: [UIView]!
    
    public var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else {
            Logger.error(msg: "No instance ViewModel")
            return
        }
        
        cityNameLabel.text = viewModel.getCurrentCityName()
        
        if let url = URL(string: viewModel.getCurrentCityImage()) {
            cityImage.kf.indicatorType = .activity
            cityImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "cityPlaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
        }
    }
    
    private func prepareUI() {
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

//MARK: Action Handlers

extension HomeViewController {
    
    @IBAction func openMap(_ sender: Any) {
        viewModel?.routeTo(.showMap)
    }
    
    @IBAction func showCityInfo(_ sender: Any) {
        viewModel?.routeTo(.showCityInfo)
    }
    
    @IBAction func openStatistics(_ sender: Any) {
        viewModel?.routeTo(.showStatistics)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        viewModel?.routeTo(.showSettings)
    }
    
    @IBAction func openLeaderBoard(_ sender: Any) {
        
    }
    
    @objc func tapMenuItem(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            Logger.error(msg: "Unable to get the tag")
            return
        }
        
        switch tag {
        case 1:
            viewModel?.routeTo(.showGame)
            
        case 2:
            viewModel?.routeTo(.showCityList)
            
        case 3:
            viewModel?.routeTo(.showRules)
            
        case 4:
            viewModel?.routeTo(.showPurchase)
            
        default:
            Logger.info(msg: "Missing tag action")
        }
    }
}

