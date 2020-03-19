//
//  MapViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var viewModel: MapViewModeling? {
        didSet {

        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityID = PreferencesManager.shared.currentCityId {
            let currentCity = StorageManager.shared.getObjectByID(City.self, id: cityID)
            let loc = currentCity?.location
            let initialLocation = CLLocation(latitude: loc!.lat, longitude: loc!.lon)
            centerMapOnLocation(location: initialLocation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.routeTo?(.back)
    }
    
    @IBAction func goToPurchase() {
        viewModel?.routeTo?(.purchase)
    }
}
