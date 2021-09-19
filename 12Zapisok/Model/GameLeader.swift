//
//  GameLeader.swift
//  12Zapisok
//
//  Created by Anton Makarov on 11.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

struct GameLeader: Codable {

    var userId: Int
    var score: Int
    var attempts: Int
    var completes: Int

    enum CondingKeys: String, CodingKey {
        case score, attempts, completes
        case userId = "user_id"
    }
}
