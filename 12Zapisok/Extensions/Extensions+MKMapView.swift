//
//  Extensions+MKMapView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {

    public func dequeue<T: MKAnnotationView>(_ type: T.Type, annotation: MKAnnotation?) -> T {
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: T.className) as? T else {
            return type.init(annotation: annotation, reuseIdentifier: T.className)
        }
        annotationView.annotation = annotation
        return annotationView
    }
    
}
