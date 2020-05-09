//
//  CityInfoViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    private enum Constants {
        static let shadowRadius: CGFloat = 4.0
        static let shadowColor = UIColor.black.withAlphaComponent(0.25)
        static let descriptionCornerRadius: CGFloat = 20.0
        static let cellWidthRatio: CGFloat = 0.80
    }
    
    @IBOutlet private weak var descriptionBlockView: UIView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var regionCodeLabel: UILabel!
    @IBOutlet private weak var cityDescription: UITextView!
    
    var viewModel: CityInfoViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        cityName.text = viewModel.getName()
        yearLabel.text = viewModel.getBuildingYear()
        populationLabel.text = viewModel.getPopulation()
        regionCodeLabel.text = viewModel.getRegionCode()
        cityDescription.text = viewModel.getDescription()
        
        imageCollectionView.register(cellType: CityImageCell.self)
        
        descriptionBlockView.rounded(cornerRadius: Constants.descriptionCornerRadius)
        descriptionBlockView.addShadow(radius: Constants.shadowRadius, color: Constants.shadowColor)
    }
    
    @IBAction func openMap() {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.routeTo?(.back)
    }
}

extension CityInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        return viewModel.getImageCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        let cell = collectionView.dequeueReusableCell(with: CityImageCell.self, for: indexPath)
        cell.setupImage(imageURL: viewModel.getImageUrl(by: indexPath.row))
        return cell
    }
}

extension CityInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * Constants.cellWidthRatio
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
