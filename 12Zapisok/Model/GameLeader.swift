//
//  GameLeader.swift
//  12Zapisok
//
//  Created by Anton Makarov on 11.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable operator_usage_whitespace

import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

final class GameLeader: Object, Mappable, Endpoint {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var userId = 0
    @objc dynamic var score = 0
    @objc dynamic var attempts = 0
    @objc dynamic var completes = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        userId      <- map["user_id"]
        score       <- map["score"]
        attempts    <- map["attempts"]
        completes   <- map["completes"]
    }
    
    static func url() -> String {
        if let cityId = PreferencesManager.shared.currentCityId {
            return "/towns/\(cityId)/statistics"
        }
        return .empty
    }
}
