//
//  Observable.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

public typealias ObserverSubscriptionToken = Int

final class Observable<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var observers: [Int: CompletionHandler] = [:]
    
    var value: T {
        didSet {
            notifyObservers(observers)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    @discardableResult
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
