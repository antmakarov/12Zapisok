//
//  OnboardingViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 07.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum OnboardingAction {
    case done
    case denied
    case skip
}

final class OnboardingViewController: UIViewController, Storyboarded {
    
    private enum Constants {
        static let edgeInset: CGFloat = 10.0
    }
    
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Private / Public variables
    
    var viewModel: OnboardingViewModeling?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(cellType: OnboardingCell.self)
    }
    
    // MARK: Setup UI
    
    override func viewDidLayoutSubviews() {
        setupCollectionLayout()
    }
    
    private func setupCollectionLayout() {
        
        let itemWidth = collectionView.frame.width
        let itemHeight = collectionView.frame.height - Constants.edgeInset * 2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Constants.edgeInset, left: 0, bottom: Constants.edgeInset, right: 0)
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

// MARK: UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.onboardingItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel else {
            fatalError("No ViewModel for Onboarding")
        }
        
        let cell = collectionView.dequeueReusableCell(with: OnboardingCell.self, for: indexPath)
        cell.configure(with: viewModel.onboardingItem(at: indexPath.row)) {
            self.scrollTo(nextStep: indexPath.row + 1)
        }
        
        return cell
    }
}
