//
//  CityListViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol CityListViewModelProtocol {
    func getNumberOfCities() -> Int
    func cityAt(index: Int) -> City
}

class CityListViewModel {
    
    private var cities = [City]()
    
    init() {
        if let cities = StorageManager.shared.getObjects(City.self) {
            self.cities = cities
        } else {
            fetchCities()
        }
    }
    
    private func fetchCities() {
        NetworkManager.shared.getCityList(completion: { result in
             self.cities = result!
             self.cities.forEach { try! StorageManager.shared.storeObject($0) }
         })
    }
}

extension CityListViewModel: CityListViewModelProtocol {
    func getNumberOfCities() -> Int {
        return cities.count
    }
    
    func cityAt(index: Int) -> City {
        return cities[index]
    }
}
