//
//  CityListViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 09/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class CityListViewController: BaseViewController {

    @IBOutlet weak var citiesCollectionView: UICollectionView!
    
    var chooseCompletion: ((City) -> Void)?
    var viewModel: CityListViewModeling? {
        didSet {
            viewModel?.setUpdateHandler {
                self.citiesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesCollectionView.register(reusableViewType: CityHeaderReusableView.self)
        citiesCollectionView.register(cellType: CityCollectionCell.self)
    }
}

// MARK: UICollectionViewDataSource Extension

extension CityListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        return viewModel.getNumberOfCities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        let city = viewModel.cityAt(index: indexPath.row)
        let cell = collectionView.dequeueReusableCell(with: CityCollectionCell.self, for: indexPath)
        cell.configure(name: city.name, url: city.imageUrl, score: Int.random(in: 1...13))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:

            let headerView = collectionView.dequeueReusableView(with: CityHeaderReusableView.self, for: indexPath)
            headerView.cityName.text = "dd"
            headerView.configure(name: viewModel.getCurrentCityName(), imageUrl: viewModel.getCurrentCityImage())
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: UICollectionViewDataSource

extension CityListViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           guard let viewModel = viewModel else {
               return
           }
           
           let selectedCity = viewModel.cityAt(index: indexPath.row)
           viewModel.saveCurrentCuty(city: selectedCity)
           chooseCompletion?(selectedCity)
           
           navigationController?.popViewController(animated: true)
       }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CityListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 190.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 330)
    }
}
