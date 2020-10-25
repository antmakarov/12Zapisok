//
//  GameStatistics.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable operator_usage_whitespace

import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

typealias GameStatisticsCompletion = ((Result<GameStatistics, Error>) -> ())

final class GameStatistics: Object, Mappable, Endpoint {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var totalScore = 0
    @objc dynamic var openNotes = 0
    @objc dynamic var totalAttempts = 0
    var citiesStats: [CityStatistics]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        totalScore      <- map["total_score"]
        openNotes       <- map["open_notes"]
        totalAttempts   <- map["total_attempts"]
        citiesStats     <- map["towns_statistics"]
    }
    
    static func url() -> String {
        return "/statistics"
    }
}

final class CityStatistics: Object, Mappable {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var countAttempts = 0
    @objc dynamic var totalAttempts = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        countAttempts   <- map["count_attempts"]
        totalAttempts   <- map["total_attempts"]
    }
}
