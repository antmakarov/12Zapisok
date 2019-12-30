//
//  StorageManager.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager {
    
    // MARK: - Realm Configuration
    
    static let shared = StorageManager()
    
    init() {
        realmConfiguration()
    }

    func realmConfiguration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                switch oldSchemaVersion {
                case 1:
                    break
                default:
                    break
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Main methods (store, remove, get - Object)
    
    func storeObjects<T: Object>(_ objects: [T]) throws {
        objects.forEach { try? storeObject($0) }
    }
    
    func storeObject<T: Object>(_ object: T) throws {
        try execute({ realm in
            try realm.write {
                realm.add(object, update: .all)
            }
        })
    }
    
    func deleteObject<T: Object>(_ object: T) throws {
        try execute({ realm in
            try realm.write {
                realm.delete(object)
            }
        })
    }
    
    func getObjectByID<T: Object>(_ type: T.Type, id: Int) -> T? {
        if let obj = try? Realm().object(ofType: type, forPrimaryKey: id) {
            return obj
        }
        
        return nil
    }
    
    func getObjects<T: Object>(_ type: T.Type) -> [T]? {
        if let objs = try? Realm().objects(type).map{ $0 } {
            return Array(objs)
        }
       
        return nil
    }
    
    func clearAllData() throws {
        try execute({ realm in
            try realm.write {
                realm.deleteAll()
            }
        })
    }

    // MARK: - Other supporting methods
    private func execute(_ completion: (_ realmObject: Realm) throws -> Void) throws {
        try completion(Realm())
    }
    
    func realmUrl() -> URL {
        return Realm.Configuration.defaultConfiguration.fileURL!
    }
}


        
//        let note = Note(id: 1, name: "Большая Покровская", description: "Центр города", image: "url", point: Point(latitude: 56.317218, longitude: 43.994982, location: nil), isOpen: true, timeFinded: "null")
//
//        let note2 = Note(id: 2, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: true, timeFinded: "null")
//
//        let note3 = Note(id: 3, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: true, timeFinded: "null")
//
//        let note4 = Note(id: 4, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: true, timeFinded: "null")
//
//        let note5 = Note(id: 5, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note6 = Note(id: 6, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note7 = Note(id: 7, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note8 = Note(id: 8, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note9 = Note(id: 9, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note10 = Note(id: 10, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note11 = Note(id: 11, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
//
//        let note12 = Note(id: 12, name: "Минина", description: "Где Кремль и Набержная", image: "url", point: Point(latitude: 56.326839, longitude: 44.006318, location: nil), isOpen: false, timeFinded: "null")
        
        //completion([note, note2, note3, note4, note5, note6, note7, note8, note9, note10, note11, note12])
        
