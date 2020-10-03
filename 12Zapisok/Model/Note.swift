//
//  Note.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import CoreLocation

class Note: Object, Mappable, Endpoint {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var noteDescription = ""
    @objc dynamic var location: Location? = nil
    @objc dynamic var hint = ""
    @objc dynamic var statistics: Statistics? = nil
    @objc dynamic var category = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var cityID = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        noteDescription <- map["description"]
        location        <- map["point"]
        hint            <- map["hint"]
        statistics      <- map["statistic"]
        category        <- map["category"]
        imageUrl        <- map["image_url"]
        cityID          <- map["town_id"]
    }
    
    static func url() -> String {
        return "/notes"
    }
}

class Statistics: Object, Mappable {
    
    @objc dynamic var isOpen: Bool = false
    @objc dynamic var isComplete: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        isOpen      <- map["is_open"]
        isComplete  <- map["is_complete"]
    }
}
