//
//  OnboardingViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 07.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, Storyboarded {
    
    var viewModel: OnboardingViewModelProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.onboardingItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel, let item = OnbordingItem(rawValue: indexPath.row) else {
            fatalError("No viewModel for onboarding")
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(with: viewModel.onboardingItem(type: item), actionCompletion: { result in
            print(indexPath.row)
            let indexPath = IndexPath(item: indexPath.row + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) {
            let indexPath = IndexPath(item: indexPath.row + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

        return cell
    }
}
