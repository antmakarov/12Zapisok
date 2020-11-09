//
//  MapAnnotationView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import MapKit

final class MapAnnotationView: MKAnnotationView {
        
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
    
    func configure(_ marker: UIImage?, number: Int) {
        let pin = MapPinView()
        pin.configure(marker, noteId: number)
        image = pin.asImage()
    }
}
