//
//  MapAnnotationView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import MapKit

public class MapAnnotationView: MKAnnotationView {
        
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = MapAnnotationView.className
        displayPriority = .defaultHigh
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clusteringIdentifier = MapAnnotationView.className
        displayPriority = .defaultHigh
    }
    
    func configure(pinUrl: String?, number: Int) {
        let pin = MapPinView()
        pin.configure(pinUrl, noteId: number)
        image = pin.asImage()
    }
}
