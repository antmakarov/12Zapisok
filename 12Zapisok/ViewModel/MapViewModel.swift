//
//  MapViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import CoreLocation

protocol MapViewModeling: AnyObject {
    var routeTo: ((MapRouter) -> Void)? { get set }
    
    func myPosition(completion: @escaping (CLLocation?) -> Void)
    func cityCenter() -> CLLocation
}

final class MapViewModel {
    
    public var routeTo: ((MapRouter) -> Void)?
    
    // MARK: Managers
    private let locationManager: LocationManaging
    private let quantityManager: HintManaging

    private let preferencesManager = PreferencesManager.shared
    private let storageManager = StorageManager.shared
        
    convenience init() {
        self.init(locationManager: LocationManager.shared, quantityManager: HintManager.shared)
    }
    
    init(locationManager: LocationManaging, quantityManager: HintManaging) {
        self.locationManager = locationManager
        self.quantityManager = quantityManager
    }
}

extension MapViewModel: MapViewModeling {
  
    public func myPosition(completion: @escaping (CLLocation?) -> Void) {
        locationManager.requestCurrentLocation { ponit in
            completion(ponit?.coordinate)
        }
    }
    
    public func cityCenter() -> CLLocation {
        if let cityID = preferencesManager.currentCityId, let currentLocation = storageManager.getObjectByID(City.self, id: cityID)?.location {
            return CLLocation(latitude: currentLocation.lat, longitude: currentLocation.lon)
        }
        
        return locationManager.currentPosition
    }
}
