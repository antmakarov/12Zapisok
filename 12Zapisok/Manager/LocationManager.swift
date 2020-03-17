//
//  LocationManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManaging {
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void)
}

class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var completionAuth: ((Bool) -> Void)?
    private var completionLocation: ((CLLocationCoordinate2D?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationManager: LocationManaging {
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        if (CLLocationManager.authorizationStatus() == .notDetermined) {
            completionAuth = completion
            locationManager.requestWhenInUseAuthorization()
           // completion(true)
        } else {
            completion(isServiceEnabled())
        }
    }
    
    func requestCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        completionLocation = completion
        locationManager.requestLocation()
    }
    
    func isServiceEnabled() -> Bool {
        return CLLocationManager.authorizationStatus() ==  .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        completionAuth?(isServiceEnabled())
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionLocation?(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        completionLocation?(locations.last?.coordinate)
    }
}
