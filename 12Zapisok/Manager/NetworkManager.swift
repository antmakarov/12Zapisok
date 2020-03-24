//
//  NetworkManager.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

protocol NetworkManaging {
    func getCityList(completion: @escaping ((Result<[City], Error>) -> ()))
    func getNoteList(parameters: Parameters, completion: @escaping ((Result<[Note], Error>) -> ()))
    func openNote(id: Int, completion: @escaping ((Bool) -> ()))
    func updateTokenIfNeeded(isForced: Bool)
}

class NetworkManager: NetworkManaging {
    
    typealias Parameters = [String: Any]
    
    static let shared = NetworkManager()
    private let userPreferences: PreferencesManager
    private var session = Alamofire.Session(configuration: .default)
    private let baseUrl = "http://138.68.102.85:9050"
        
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        session = Session(configuration: configuration)
        userPreferences = PreferencesManager.shared
    }
    
    public func getCityList(completion: @escaping ((Result<[City], Error>) -> ())) {
        fetchArrayOf(type: City.self) { completion($0) }
    }

    public func getNoteList(parameters: Parameters, completion: @escaping ((Result<[Note], Error>) -> ())) {
        fetchArrayOf(type: Note.self, parameters) { completion($0) }
    }
    
    public func openNote(id: Int, completion: @escaping ((Bool) -> ())) {
        let url = baseUrl + String(format: Endpoints.openNote.rawValue, id)
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: configureHeaders())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let result):
                let response = result as! NSDictionary
                let status = response.object(forKey: "success") as? Bool
                completion(status!)
            
            case .failure(let error):
                Logger.error(msg: "Unable to get user token - \(error)")
                completion(false)
            }
        }
    }

    //MARK: Private methods
    
    public func updateTokenIfNeeded(isForced: Bool) {
        if userPreferences.userToken == nil || isForced {
            getUserToken { [weak self] token in
                self?.userPreferences.userToken = token
            }
        } else {
            Logger.info(msg: "App Token: " + (userPreferences.userToken ?? .empty))
        }
    }

    private func fetchObject<T: Object>(type: T.Type, completion: @escaping ((Result<T, Error>)) -> ())  where T:Mappable, T:Endpoint {
        
        let requestURL = baseUrl + type.url()
        Logger.info(msg: requestURL)

        AF.request(requestURL, encoding: JSONEncoding.default, headers: configureHeaders())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            
            switch response.result {
            case .success(let value):
                Logger.info(msg: value)
                if let response = Mapper<T>().map(JSONObject: value) {
                    completion(.success(response))
                } else {
                    completion(.error(NetworkError.parsingError))
                }
            case .failure(let error):
                Logger.error(msg: error.localizedDescription)
                completion(.error(error))
            }
        }
    }
    
    private func fetchArrayOf<T: Object>(type: T.Type, _ parameters: Parameters? = nil, completion: @escaping ((Result<[T], Error>)) -> ())  where T:Mappable, T:Endpoint {
        
        let requestURL = baseUrl + type.url()
        Logger.info(msg: requestURL)
        
        AF.request(requestURL, parameters: parameters, encoding: URLEncoding.default, headers: configureHeaders())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            
            switch response.result {
            case .success(let value):
                Logger.info(msg: value)
                if let response = Mapper<T>().mapArray(JSONObject: value) {
                    completion(.success(response))
                } else {
                    completion(.error(NetworkError.parsingError))
                }
            case .failure(let error):
                Logger.error(msg: error.localizedDescription)
                completion(.error(error))
            }
        }
    }
    
    private func getUserToken(completion: @escaping (String?) -> ()) {
        AF.request(baseUrl + Endpoints.newToken.rawValue, method: .post, encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let result):
                let response = result as! NSDictionary
                let userToken = response.object(forKey: "token") as? String
                completion(userToken)
            
            case .failure(let error):
                Logger.error(msg: "Unable to get user token - \(error)")
                completion(nil)
            }
        }
    }
    
    private func configureHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        
        // 1. Token
        headers.add(tokenHeader())
        
        return headers
    }
    
    private func tokenHeader() -> HTTPHeader {
        let name = "Authorization"
        let value = "JWT " + (userPreferences.userToken ?? "")
        return HTTPHeader(name: name, value: value)
    }
}
