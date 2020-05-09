//
//  Observable.swift
//  12Zapisok
//
//  Created by Anton Makarov on 29.04.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

protocol ObserverProtocol {
    var id: Int { get set }
    func onValueChanged(_ value: Any?)
}

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
    
    func addObserver(_ observer: ObserverProtocol, completion: @escaping CompletionHandler) {
        observers[observer.id] = completion
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        observers.removeValue(forKey: observer.id)
    }
    
    func notifyObservers(_ observers: [Int: CompletionHandler]) {
        observers.forEach { $0.value(value) }
    }
    
    deinit {
        observers.removeAll()
    }
}
