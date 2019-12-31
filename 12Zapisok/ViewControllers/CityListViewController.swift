//
//  CityListViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 09/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var citiesCollectionView: UICollectionView!
    weak var coordinator: MainCoordinator?
    
    var chooseCompletion: ((City) -> Void)?
    var viewModel: CityListViewModelProtocol? {
        didSet {
            viewModel?.setUpdateHandler {
                self.citiesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesCollectionView.register(UINib(nibName: "CityCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CityCollectionCell")
    }
}

extension CityListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        return viewModel.getNumberOfCities() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        let city = viewModel.cityAt(index: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionCell", for: indexPath) as! CityCollectionCell
        cell.configure(name: city.name, url: city.imageUrl, score: Int.random(in: 1...13))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CityHeaderReusableView.self)", for: indexPath) as? CityHeaderReusableView else {
                    fatalError("Invalid view type")
            }

            headerView.configure(name: viewModel.getCurrentCityName(), imageUrl: viewModel.getCurrentImage())
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        
        let selectedCity = viewModel.cityAt(index: indexPath.row)
        viewModel.saveCurrentCuty(city: selectedCity)
        chooseCompletion?(selectedCity)
        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 190.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 330)
    }
    
}
