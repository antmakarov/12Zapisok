//
//  CityListViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 09/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class CityListViewController: BaseViewController {

    private enum Constants {
        static let changeTitle = "Сменить город"
        static let chooseTitle = "Выбрать город"
        
        static let cellHeight: CGFloat = 190.0
        static let cellSpacing: CGFloat = 30.0
        static let collectionHeaderHeight: CGFloat = 260.0
        static let collectionSmallHeaderHeight: CGFloat = 210.0
    }
    
    @IBOutlet private weak var citiesCollectionView: UICollectionView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorView: ErrorView!
    
    var chooseCompletion: ((City) -> Void)?
    var viewModel: CityListViewModeling? {
        didSet {
            viewModel?.setUpdateHandler {
                self.citiesCollectionView.reloadData()
                self.errorView.isHidden = self.viewModel?.getNumberOfCities() != 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesCollectionView.register(reusableViewType: CityHeaderReusableView.self)
        citiesCollectionView.register(cellType: CityCollectionCell.self)
        setupUI()
    }
    
    @IBAction private func backButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
    
    private func setupUI() {
        errorView.configureHandler { [weak self] in
            self?.viewModel?.fetchCities()
        } back: { [weak self] in
            self?.viewModel?.closeButtonPressed?()
        }

        if let viewModel = viewModel {
            if viewModel.isOnboarding {
                backButton.isHidden = true
                titleLabel.text = Constants.chooseTitle
            } else {
                backButton.isHidden = false
                titleLabel.text = Constants.changeTitle
            }
        }
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
           viewModel.saveCurrentCity(at: indexPath.row)
           chooseCompletion?(selectedCity)
           
           viewModel.closeButtonPressed?()
       }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CityListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - Constants.cellSpacing) / 2
        return CGSize(width: width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = (viewModel?.hasChosenCity() == true) ? Constants.collectionHeaderHeight : Constants.collectionSmallHeaderHeight
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
