//
//  LocationManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import CoreLocation

public struct MapPoint {
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D?) {
        latitude = coordinate?.latitude ?? 0
        longitude = coordinate?.longitude ?? 0
    }
}

protocol LocationManaging {
    var currentPosition: CLLocation { get }

    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func requestCurrentLocation(completion: @escaping (MapPoint?) -> Void)
    
    func distanceFromCoordinates(_ latitude: Double, _ longitude: Double) -> Double
    func distanceFromPoint(_ point: CLLocation) -> Double
}

class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var completionAuth: ((Bool) -> Void)?
    private var completionLocation: ((MapPoint?) -> Void)?
    private var location = CLLocation()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: LocationManaging {
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        if (CLLocationManager.authorizationStatus() == .notDetermined) {
            completionAuth = completion
            locationManager.requestWhenInUseAuthorization()
        } else {
            completion(isLocationEnabled())
        }
    }
    
    func requestCurrentLocation(completion: @escaping (MapPoint?) -> Void) {
        completionLocation = completion
        locationManager.requestLocation()
    }
    
    public var currentPosition: CLLocation {
        return location
    }
    
    public func distanceFromCoordinates(_ latitude: Double, _ longitude: Double) -> Double {
        return distanceFromPoint(CLLocation(latitude: latitude, longitude: longitude))
    }

    public func distanceFromPoint(_ point: CLLocation) -> Double {
        let distanceInMeters = point.distance(from: currentPosition)
        return distanceInMeters
    }
    
    func isLocationEnabled() -> Bool {
        return CLLocationManager.authorizationStatus() ==  .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        completionAuth?(isLocationEnabled())
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionLocation?(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastCoordinate = locations.last?.coordinate {
            location = CLLocation(latitude: lastCoordinate.latitude, longitude: lastCoordinate.longitude)
        }
        completionLocation?(MapPoint(coordinate: locations.last?.coordinate))
    }
}
