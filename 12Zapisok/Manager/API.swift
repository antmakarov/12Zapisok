//
//  ServerPath.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}

enum ServerPaths: String {
    case login = "login"
    case register = "register"
    case loadNotes = "load_notes"
    // . . .
}
