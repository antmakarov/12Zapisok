//
//  Observable.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

public typealias ObserverSubscriptionToken = Int

class Observable<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var observers: [Int: CompletionHandler] = [:]
    
    var value: T {
        didSet {
            notifyObservers(observers)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(completion: @escaping CompletionHandler) -> ObserverSubscriptionToken {
        let key = (observers.keys.max() ?? 0) + 1
        observers[key] = completion
        return key
    }
    
    func removeObserver(_ token: ObserverSubscriptionToken) {
        observers[token] = nil
    }
    
    func notifyObservers(_ observers: [Int: CompletionHandler]) {
        observers.forEach { $0.value(value) }
    }
    
    deinit {
        observers.removeAll()
    }
}
