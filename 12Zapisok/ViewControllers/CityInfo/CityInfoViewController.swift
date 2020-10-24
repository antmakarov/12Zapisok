//
//  CityInfoViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class CityInfoViewController: UIViewController, UIGestureRecognizerDelegate {
    
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
    
    @IBOutlet private weak var swipeBottomConstraint: NSLayoutConstraint!
    
    var viewModel: CityInfoViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(descriptionSwipeUp))
        swipeUp.direction = .up
        let swipeUp2 = UISwipeGestureRecognizer(target: self, action: #selector(descriptionSwipeDown))
        swipeUp2.direction = .down
        swipeUp.delegate = self
        swipeUp2.delegate = self

        cityDescription.addGestureRecognizer(swipeUp)
        cityDescription.addGestureRecognizer(swipeUp2)

        cityName.text = viewModel.getName()
        yearLabel.text = viewModel.getBuildingYear()
        populationLabel.text = viewModel.getPopulation()
        regionCodeLabel.text = viewModel.getRegionCode()
        cityDescription.text = viewModel.getDescription()
        
        imageCollectionView.register(cellType: CityImageCell.self)
        
        descriptionBlockView.rounded(cornerRadius: Constants.descriptionCornerRadius)
        descriptionBlockView.addShadow(radius: Constants.shadowRadius, color: Constants.shadowColor)
    }
    
    @IBAction private func openMap() {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.routeTo?(.back)
    }
    
    @objc
    private func descriptionSwipeUp(_ sender: UISwipeGestureRecognizer) {
        swipeBottomConstraint.constant = -200
        isModalInPresentation = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func descriptionSwipeDown(_ sender: UISwipeGestureRecognizer) {
        swipeBottomConstraint.constant = 5
        isModalInPresentation = false
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
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
