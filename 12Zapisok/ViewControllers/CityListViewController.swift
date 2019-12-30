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
    
    var viewModel: CityListViewModelProtocol?
    var chooseCompletion: ((City) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesCollectionView.register(UINib(nibName: "CityCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CityCollectionCell")
        citiesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 3))
    }
}

extension CityListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfCities() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionCell", for: indexPath) as! CityCollectionCell
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        
        chooseCompletion?(viewModel.cityAt(index: indexPath.row))
        navigationController?.popViewController(animated: true)
    }
}
