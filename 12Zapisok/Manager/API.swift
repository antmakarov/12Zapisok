//
//  ServerPath.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}

enum NetworkError: Error {
    case badURL
    case parsingError
    case emptyResponse
}
