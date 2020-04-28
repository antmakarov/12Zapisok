//
//  CityInfoViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var regionCodeLabel: UILabel!
    @IBOutlet private weak var cityDescription: UITextView!
    
    var viewModel: CityInfoViewModeling? {
        didSet {
            
        }
    }
    
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CityImageCell.self, for: indexPath)
        return cell
    }
}

extension CityInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.75
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
