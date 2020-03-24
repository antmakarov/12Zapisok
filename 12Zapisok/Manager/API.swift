//
//  ServerPath.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

public enum Endpoints: String {
    case openNote = "/notes/%d/open"
    case newToken = "/generate_token"
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}

enum NetworkError: Error {
    case badURL
    case parsingError
    case emptyResponse
}

enum TypeFetcher {
    case network
    case storage
}
