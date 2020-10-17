//
//  City.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable operator_usage_whitespace

import RealmSwift
import ObjectMapper
import CoreLocation

protocol Endpoint {
    static func url() -> String
}

final class City: Object, Mappable, Endpoint {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var cityDescription = ""
    @objc dynamic var cityInfo: CityInfo?
    @objc dynamic var location: Location?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        imageUrl        <- map["image_url"]
        cityDescription <- map["description"]
        cityInfo        <- map["town_info"]
        location        <- map["point"]
    }
    
    static func url() -> String {
        return "/towns"
    }
}

final class Location: Object, Mappable {

    @objc dynamic var lat = 0.0
    @objc dynamic var lon = 0.0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
    }
    
    func cll() -> CLLocation {
        return CLLocation(latitude: lat, longitude: lon)
    }
}
