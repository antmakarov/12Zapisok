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

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkManager: NotesFetchProtocol {
    func fetchNotes(completion: ([Note]?) -> ()) {
        
    }
    
    public func fetchUsers() {
        let url = URL(string: "https://reqres.in/api/users/2")!
        
        Alamofire.request(url)

            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let users):
                    print(users)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    
    
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
    
    func getCityList(completion: @escaping (([City]?) -> ())) {
        fetchArrayOf(type: City.self) { completion($0) }
    }
    
    private func fetchObject<T: Object>(type: T.Type, completion: @escaping (T?) -> ())  where T:Mappable, T:Endpoint {
        
        let requestURL = baseUrl + type.url()
        Logger.error(msg: requestURL)
        
        Alamofire.request(requestURL, encoding: JSONEncoding.default, headers: tokenHeader)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            
            switch response.result {
            case .success(let value):
                Logger.info(msg: value)
                if let response = Mapper<T>().map(JSONObject: value) {
                    completion(response)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                Logger.error(msg: error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func fetchArrayOf<T: Object>(type: T.Type, completion: @escaping ([T]?) -> ())  where T:Mappable, T:Endpoint {
        
        let requestURL = baseUrl + type.url()
        Logger.error(msg: requestURL)
        
        Alamofire.request(requestURL, encoding: JSONEncoding.default, headers: tokenHeader)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            
            switch response.result {
            case .success(let value):
                Logger.info(msg: value)
                if let response = Mapper<T>().mapArray(JSONObject: value) {
                    completion(response)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                Logger.error(msg: error.localizedDescription)
                completion(nil)
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
