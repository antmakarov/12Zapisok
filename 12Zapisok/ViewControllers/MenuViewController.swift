//
//  MenuViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, Storyboarded {
    
    private enum Constants {
        static let shadowOpacity: Float = 0.2
        static let shadowOffset = CGSize(width: 1, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor = UIColor.black.cgColor
    }
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private var circleMenuImages: [UIImageView]!

    public var viewModel: MenuViewModelProtocol?
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel {
            cityNameLabel.text = viewModel.getCurrentCityName()
            
            if let url = URL(string: viewModel.getCurrentImage()) {
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
    }
    
    @IBAction func chooseCity(_ sender: Any) {
        coordinator?.openCityList()
    }
    
    private func prepareUI() {
        circleMenuImages.forEach {
                   $0.layer.shadowOpacity = Constants.shadowOpacity
                   $0.layer.shadowOffset = Constants.shadowOffset
                   $0.layer.shadowRadius = Constants.shadowRadius
                   $0.layer.shadowColor = Constants.shadowColor
               }
    }
}

