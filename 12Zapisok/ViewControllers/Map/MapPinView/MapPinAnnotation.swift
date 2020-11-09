//
//  MapPinAnnotation.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import MapKit

protocol MapAnnotationModeling: MKAnnotation {
    var id: Int { get set }
    var marker: UIImage? { get set }
}

final class MapPinAnnotation: NSObject, MapAnnotationModeling {
    public var coordinate: CLLocationCoordinate2D
    public var id: Int
    public var marker: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, id: Int, marker: UIImage?) {
        self.coordinate = coordinate
        self.id = id
        self.marker = marker
    }
}
