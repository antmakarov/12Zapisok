//
//  MapPinAnnotation.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import MapKit

public class MapPinAnnotation: NSObject, MapAnnotationModeling {
    public var coordinate: CLLocationCoordinate2D
    public var id: String
    public var pinUrl: String?
    
    init(coordinate: CLLocationCoordinate2D, id: String, pinUrl: String?) {
        self.coordinate = coordinate
        self.id = id
        self.pinUrl = pinUrl
    }
}
