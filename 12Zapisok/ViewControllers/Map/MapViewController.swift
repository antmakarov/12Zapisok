//
//  MapViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    var viewModel: MapViewModeling?
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var noteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.register(MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: MapAnnotationView.className)
        mapView.register(MapClusterView.self, forAnnotationViewWithReuseIdentifier: MapClusterView.className)
        
        noteButton.isHidden = true
        
        if let cityID = PreferencesManager.shared.currentCityId {
            let currentCity = StorageManager.shared.getObjectByID(City.self, id: cityID)
            let loc = currentCity?.location
            let initialLocation = CLLocation(latitude: loc?.lat ?? 0, longitude: loc?.lon ?? 0)
            centerMapOnLocation(location: initialLocation)
        }
        
        viewModel?.fillPinNotes { [weak self] pins in
            self?.mapView.addAnnotations(pins)
        }
    }
        
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction private func showMyPosition() {
        if let viewModel = viewModel {
            viewModel.myPosition { location in
                if let location = location {
                    self.centerMapOnLocation(location: location)
                }
            }
        }
    }
    
    @IBAction private func showCityCenter() {
        if let viewModel = viewModel {
            centerMapOnLocation(location: viewModel.cityCenter())
        }
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.routeTo?(.back)
    }
    
    @IBAction private func goToPurchase() {
        viewModel?.routeTo?(.purchase)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MapAnnotationModeling {
            let view = mapView.dequeue(MapAnnotationView.self, annotation: annotation)
            view.clusteringIdentifier = MapAnnotationView.className
            view.configure(annotation.marker, number: annotation.id)
            return view
        } else if let cluster = annotation as? MKClusterAnnotation {
            return mapView.dequeue(MapClusterView.self, annotation: cluster)
        } else {
            return nil
        }
    }
}
