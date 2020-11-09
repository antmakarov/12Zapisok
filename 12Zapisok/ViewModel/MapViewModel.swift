//
//  MapViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import CoreLocation
import Kingfisher

protocol MapViewModeling: AnyObject {
    var routeTo: ((MapRouter) -> Void)? { get set }
    
    func myPosition(completion: @escaping (CLLocation?) -> Void)
    func cityCenter() -> CLLocation
    func fillPinNotes(completion: @escaping ([MapAnnotationModeling]) -> Void)
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
    
    public func fillPinNotes(completion: @escaping ([MapAnnotationModeling]) -> Void) {
        guard let notes = storageManager.getObjects(Note.self) else {
            return
        }
        
        var pins: [MapAnnotationModeling] = []
        let group = DispatchGroup()
        
        for (index, note) in notes.enumerated() {
            group.enter()
            if let location = note.location, !location.isNullLocation() {
                note.imageUrl.downloadImage { image in
                    let pin = MapPinAnnotation(coordinate: location.cllCoordinate(),
                                               id: index + 1,
                                               marker: image)
                    pins.append(pin)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(pins)
        }
    }
}
