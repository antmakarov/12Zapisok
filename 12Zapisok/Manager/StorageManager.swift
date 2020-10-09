//
//  StorageManager.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import RealmSwift

final class StorageManager {

    // MARK: - Realm Configuration
    
    static let shared = StorageManager()
    
    init() {
        realmConfiguration()
    }

    func realmConfiguration() {
        let config = Realm.Configuration(schemaVersion: 1) { _, oldSchemaVersion in
                switch oldSchemaVersion {
                case 1:
                    break
                default:
                    break
                }
        }
        
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: - Main methods (store, remove, get - Object)
    
    func storeObjects<T: Object>(_ objects: [T]) throws {
        objects.forEach { try? storeObject($0) }
    }
    
    func storeObject<T: Object>(_ object: T) throws {
        try execute { realm in
            try realm.write {
                realm.add(object, update: .all)
            }
        }
    }
    
    func deleteObject<T: Object>(_ object: T) throws {
        try execute { realm in
            try realm.write {
                realm.delete(object)
            }
        }
    }
    
    func getObjectByID<T: Object>(_ type: T.Type, id: Int) -> T? {
        if let obj = try? Realm().object(ofType: type, forPrimaryKey: id) {
            return obj
        }
        
        return nil
    }
    
    func getObjects<T: Object>(_ type: T.Type) -> [T]? {
        if let objs = try? Array(Realm().objects(type)), !objs.isEmpty {
            return objs
        }
       
        return nil
    }
    
    func clearAllData() throws {
        try execute { realm in
            try realm.write {
                realm.deleteAll()
            }
        }
    }

    // MARK: - Other supporting methods
    
    private func execute(_ completion: (_ realmObject: Realm) throws -> Void) throws {
        try completion(Realm())
    }
    
    func realmUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
}
