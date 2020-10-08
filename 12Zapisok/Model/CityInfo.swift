//
//  CityInfo.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

class CityInfo: Object, Mappable {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var fullDescription = ""
    @objc dynamic var baseYear = 0
    @objc dynamic var population = 0
    @objc dynamic var regionCode = 0
    var imageUrls = List<String>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        name            <- map["name"]
        fullDescription <- map["full_description"]
        baseYear        <- map["base_year"]
        population      <- map["population"]
        regionCode      <- map["region_code"]
        imageUrls       <- (map["image_urls"], RealmTypeCastTransform())
    }
}
