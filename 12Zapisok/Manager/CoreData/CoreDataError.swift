//
//  CoreDataError.swift
//  12Zapisok
//
//  Created by Anton Makarov on 15.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import Foundation

enum CoreDataError {
    case noContext
    case noEntity(String)

    var error: String {
        switch self {
        case .noContext:
            return "Decoder does not contain a managedObjectContext in userInfo"

        case let .noEntity(error):
            return "Could not create entity for \(error)"
        }
    }
}
