//
//  ServerPath.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

public enum Endpoint {
    case citiList
    case notes
    case statistics
    case leadersForCity(Int)
    case openNote(Int)
    case completeNote(Int)
    case attempsNote(Int)
    case newToken

    var url: URL? {
        switch self {
        case .citiList:
            return makeEndpoint("towns")

        case .notes:
            return makeEndpoint("notes")

        case .statistics:
            return makeEndpoint("statistics")

        case let .leadersForCity(cityId):
            return makeEndpoint("towns/\(cityId)/statistics")

        case let .openNote(noteId):
            return makeEndpoint("notes/\(noteId)/open")

        case let .completeNote(noteId):
            return makeEndpoint("notes/\(noteId)/complete")

        case let .attempsNote(noteId):
            return makeEndpoint("notes/\(noteId)/attempts")

        case .newToken:
            return makeEndpoint("generate_token")
        }
    }

    func makeEndpoint(_ endpoint: String) -> URL? {
        URL(string: "http://138.68.102.85:9050/\(endpoint)")
    }
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}

enum Method: String {
    case GET
    case POST
    case DELETE
}

enum TypeFetcher {
    case network
    case storage
}

enum APIError: Error {
    case nonHTTPResponse
    case responseError(code: Int)
    case decodeError
    case other
}
