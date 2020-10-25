//
//  Note.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//
// swiftlint:disable operator_usage_whitespace

import RealmSwift
import ObjectMapper
import CoreLocation

typealias NoteListCompletion = ((Result<[Note], Error>) -> ())

final class Note: Object, Mappable, Endpoint {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var noteDescription = ""
    @objc dynamic var address = ""
    @objc dynamic var location: Location?
    @objc dynamic var hint = ""
    @objc dynamic var statistics: NoteStatistics?
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
        address         <- map["address"]
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
