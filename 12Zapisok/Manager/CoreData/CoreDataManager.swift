//
//  CoreDataManager.swift
//  12Zapisok
//
//  Created by Anton Makarov on 13.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import CoreData

final class CoreDataManager: NSObject {

    var managedObjectContext: NSManagedObjectContext?
    var storeName = "CoreDataStore"
    static let shared = CoreDataManager()

    override init() {
        super.init()
        managedObjectContext = persistentContainer.viewContext
    }

    // MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: storeName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error in loading persistent store \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving Support

    func saveContext () {
        do {
            try managedObjectContext?.save()
        } catch let saveError as NSError {
            fatalError("SaveContext error: \(saveError.localizedDescription)")
        }
    }

    func fetchObjects<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName())
        fetchRequest.predicate = predicate

        do {
            return try managedObjectContext?.fetch(fetchRequest) ?? []
        } catch {
            Logger.error(msg: error.localizedDescription)
            return []
        }
    }

    func fetchObject<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate? = nil) -> T? {
        return fetchObjects(entityClass: T.self, predicate: predicate).last
    }

    func fetchObjectById<T: NSManagedObject>(entityClass: T.Type, id: Int) -> T? {
        let predicate = NSPredicate(format: "id = %ld", id)
        return fetchObjects(entityClass: T.self, predicate: predicate).last
    }
}

extension NSManagedObject {
    public class func entityName() -> String {
        let name = NSStringFromClass(self)
        return name.components(separatedBy: ".").last ?? name
    }
}
