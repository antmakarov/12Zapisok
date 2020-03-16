//
//  OnboardingViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 07.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, Storyboarded {
    
    private enum Constants {
        static let edgeInset: CGFloat = 10.0
        static let collectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    var viewModel: OnboardingViewModelProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionLayout()
        collectionView.register(cellType: OnboardingCell.self)
    }
    
    private func setupCollectionLayout() {
        
        let itemWidth = collectionView.frame.width
        let itemHeight = collectionView.frame.height - Constants.edgeInset * 2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.collectionInset
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }
    
    private func scrollTo(nextStep: Int) {
        let indexPath = IndexPath(item: nextStep, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.onboardingItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel, let item = OnbordingItem(rawValue: indexPath.row) else {
            fatalError("No ViewModel for Onboarding")
        }
        
        let cell = collectionView.dequeueReusableCell(with: OnboardingCell.self, for: indexPath)
        cell.configure(with: viewModel.onboardingItem(type: item), actionCompletion: { result in
            self.scrollTo(nextStep: indexPath.row + 1)
        }) {
            self.scrollTo(nextStep: indexPath.row + 1)
        }

        return cell
    }
}
