//
//  Note.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import CoreLocation

struct Note: Equatable, Codable {
    var id: Int
    var name: String
    var description: String
    var image: String
    
    var point: Point
    var isOpen: Bool
    var timeFinded: String?
}

struct Point: Equatable, Codable {
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    // http://138.68.102.85:9050/notes
    var latitude: Float
    var longitude: Float
    //var location: CLLocationCoordinate2D? = nil
}
