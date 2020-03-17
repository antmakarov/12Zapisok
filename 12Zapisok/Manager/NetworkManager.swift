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
    func getUserToken(completion: @escaping (String?) -> ())
    func getCityList(completion: @escaping ((Result<[City], Error>) -> ()))
    func getNoteList(parameters: Parameters, completion: @escaping ((Result<[Note], Error>) -> ()))
}

class NetworkManager: NetworkManaging {
    
    typealias Parameters = [String: Any]
    
    static let shared = NetworkManager()
    private var session = Alamofire.SessionManager(configuration: .default)
    private let baseUrl = "http://138.68.102.85:9050"
    private let tokenHeader = ["Authorization": "JWT " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6N30.ulAb9HRDksOFrkrApi51oJgVR-qmJZD6O2rYHZCqLPA"]
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        session = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getCityList(completion: @escaping ((Result<[City], Error>) -> ())) {
        fetchArrayOf(type: City.self) { completion($0) }
    }

    func getNoteList(parameters: Parameters, completion: @escaping ((Result<[Note], Error>) -> ())) {
        fetchArrayOf(type: Note.self, parameters) { completion($0) }
    }
    
    private func fetchObject<T: Object>(type: T.Type, completion: @escaping ((Result<T, Error>)) -> ())  where T:Mappable, T:Endpoint {
        
        let requestURL = baseUrl + type.url()
        Logger.info(msg: requestURL)

        Alamofire.request(requestURL, encoding: JSONEncoding.default, headers: tokenHeader)
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
        
        Alamofire.request(requestURL, parameters: parameters, encoding: URLEncoding.default, headers: tokenHeader)
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
    
    func getUserToken(completion: @escaping (String?) -> ()) {
        Alamofire.request(self.baseUrl + "/generate_token", method: .post, encoding: JSONEncoding.default)
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
}
