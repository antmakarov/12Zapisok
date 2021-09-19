//
//  AuthToken.swift
//  12Zapisok
//
//  Created by Anton Makarov on 15.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import Foundation

struct AuthToken: Codable {

    var token: String

    enum CondingKeys: String, CodingKey {
        case token
    }
}
