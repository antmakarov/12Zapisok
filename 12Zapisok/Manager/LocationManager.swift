//
//  LocationManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 25.11.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

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
    func closeToCoordinate(_ coordinate: CLLocation, with type: Remoteness) -> Bool
}

final class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var completionAuth: ((Bool) -> Void)?
    private var completionLocation: ((MapPoint?) -> Void)?
    private var location = CLLocation()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func startLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    private func isLocationEnabled() -> Bool {
        return CLLocationManager.authorizationStatus() ==  .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways
    }
}

extension LocationManager: LocationManaging {
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
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
    
    public func closeToCoordinate(_ coordinate: CLLocation, with type: Remoteness) -> Bool {
        return distanceFromPoint(coordinate) <= type.distanceInMeters()
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

// MARK: Utility

enum Remoteness: Double, CaseIterable {
    
    case close = 50
    case average = 100
    case far = 500
    case veryFar = 1000
    
    init(distance: Double) {
        self = Remoteness.allCases.first(where: { $0.rawValue >= distance }) ?? .veryFar
    }
    
    func distanceInMeters() -> Double {
        return rawValue
    }
    
    func closestStatus() -> String {
        switch self {
        case .close:
            return "Жарко, очень рядом"
        case .average:
            return "Теплее, уже ближе"
        case .far, .veryFar:
            return "Холодно, бррр.."
        }
    }
}
