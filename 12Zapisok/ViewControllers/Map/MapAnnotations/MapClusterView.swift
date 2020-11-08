//
//  MapClusterView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import MapKit

public class MapClusterView: MKAnnotationView {
    
    private enum Constants {
        static let labelFont = UIFont.boldSystemFont(ofSize: 17.0)
        static let clusterSize: CGFloat = 50.0
        static let centerOffset = CGPoint(x: 0, y: -10)
    }
    
    private var label: UILabel!
    
    override public var annotation: MKAnnotation? {
        willSet {
            newValue.map( configure(annotation:) )
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultLow
        collisionMode = .circle
        centerOffset = Constants.centerOffset
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        collisionMode = .circle
        centerOffset = Constants.centerOffset
        setupView()
    }
    
    private func setupView() {
        label = UILabel(frame: CGRect(x: -(Constants.clusterSize / 2),
                                      y: -(Constants.clusterSize / 2),
                                      width: Constants.clusterSize,
                                      height: Constants.clusterSize))
        label.layer.cornerRadius = Constants.clusterSize / 2
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.appColor.cgColor
        
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.textColor = .appColor
        label.textAlignment = .center
        label.font = Constants.labelFont
        
        addSubview(label)
        frame.size = label.frame.size
    }
}

extension MapClusterView {
    public func configure(annotation: MKAnnotation) {
        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }
        label.text = "\(annotation.memberAnnotations.count)"
    }
}
