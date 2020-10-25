//
//  ServerPath.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

public enum Endpoints: String {
    case openNote = "/notes/%d/open"
    case completeNote = "/notes/%d/complete"
    case attempsNote = "/notes/%d/attempts"
    case newToken = "/generate_token"
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}

enum ResponseStatus {
    case error
    case networkError
    case empty
    case success
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
