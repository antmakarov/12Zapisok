//
//  GameStatistics.swift
//  12Zapisok
//
//  Created by Anton Makarov on 10.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

struct GameStatistics: Codable {

    var totalScore: Int
    var openNotes: Int
    var totalAttempts: Int
    var citiesStats: [CityStatistics]?

    enum CondingKeys: String, CodingKey {
        case totalScore = "total_score"
        case openNotes = "open_notes"
        case totalAttempts = "total_attempts"
        case citiesStats = "towns_statistics"
    }
}

struct CityStatistics: Codable {

    var name: String
    var countAttempts: Int
    var totalAttempts: Int

    enum CondingKeys: String, CodingKey {
        case name
        case countAttempts = "count_attempts"
        case totalAttempts = "total_attempts"
    }
}
