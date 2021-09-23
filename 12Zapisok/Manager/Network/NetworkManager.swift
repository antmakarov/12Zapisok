//
//  NetworkManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 09.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import Combine
import Foundation

typealias CityListPublisher = AnyPublisher<[City], APIError>
typealias NotesPublisher = AnyPublisher<[Note], APIError>
typealias GameStatisticsPublisher = AnyPublisher<GameStatistics, APIError>
typealias LeaderboardPublisher = AnyPublisher<[GameLeader], APIError>
typealias ResponsePublisher = AnyPublisher<Bool, APIError>
typealias AuthTokenPublisher = AnyPublisher<AuthToken, APIError>

typealias Parameters = [String: Any]

protocol NetworkManaging {
    func getCityList() -> CityListPublisher
    func getGameStats() -> GameStatisticsPublisher
    func getGameLeaders() -> LeaderboardPublisher
    func getNoteList(parameters: Parameters) -> NotesPublisher
    func openNote(id: Int) -> ResponsePublisher
    func completeNote(id: Int) -> ResponsePublisher
    func setNoteAttemps(id: Int, attemps: Int) -> ResponsePublisher
    func updateTokenIfNeeded() -> AuthTokenPublisher
}

final class NetworkManager {

    static let shared = NetworkManager()

    private let userPreferences: PreferencesManager
    private let storageManager: CoreDataManager

    private var baseUrl = "http://138.68.102.85:9050/"
    private var subscription = Set<AnyCancellable>()

    init() {
        userPreferences = PreferencesManager.shared
        storageManager = CoreDataManager.shared
    }

    private func fetch<T: Decodable>(endpoint: Endpoint, mwthod: Method) -> AnyPublisher<T, APIError> {
        let urlRequest = request(for: endpoint, method: mwthod)

        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = storageManager.managedObjectContext
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.nonHTTPResponse
                }
                let statusCode = httpResponse.statusCode
                if !(200..<300).contains(statusCode) {
                    throw APIError.responseError(code: statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { self.handlerror(error: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private func request(for endopoint: Endpoint, method: Method) -> URLRequest {
        guard let url = endopoint.url else { preconditionFailure("") }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if case .newToken = endopoint {
            // no - op
        } else {
            request.allHTTPHeaderFields = headers()
        }
        return request
    }

    private func handlerror(error: Error) -> APIError {
        switch error {
        case is DecodingError:
            return .decode(error: error)

        case let apiError as APIError:
            return apiError

        default:
            return .other
        }
    }

    private func headers() -> [String: String] {
        let token = ["Authorization": "JWT " + (userPreferences.userToken ?? .empty)]
        return token
    }
}

extension NetworkManager: NetworkManaging {
    func getCityList() -> CityListPublisher {
        fetch(endpoint: .citiList, mwthod: .GET)
    }

    func getGameStats() -> GameStatisticsPublisher {
        fetch(endpoint: .statistics, mwthod: .GET)
    }

    func getNoteList(parameters: Parameters) -> NotesPublisher {
        fetch(endpoint: .notes, mwthod: .GET)
    }

    func getGameStats() -> ResponsePublisher {
        fetch(endpoint: .statistics, mwthod: .GET)
    }

    func getGameLeaders() -> LeaderboardPublisher {
        fetch(endpoint: .leadersForCity(2), mwthod: .GET)
    }

    func openNote(id: Int) -> ResponsePublisher {
        fetch(endpoint: .openNote(id), mwthod: .GET)
    }

    func completeNote(id: Int) -> ResponsePublisher {
        fetch(endpoint: .completeNote(id), mwthod: .GET)
    }

    func setNoteAttemps(id: Int, attemps: Int) -> ResponsePublisher {
        fetch(endpoint: .attempsNote(id), mwthod: .GET)
    }

    func updateTokenIfNeeded() -> AuthTokenPublisher {
        fetch(endpoint: .newToken, mwthod: .POST)
    }
}
