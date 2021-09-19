//
//  Extensions+Decoder.swift
//  12Zapisok
//
//  Created by Anton Makarov on 15.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import CoreData

extension Decoder {
    var managedObjectContext: NSManagedObjectContext? {
        return userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext
    }

    func getEntity(for name: String) -> NSEntityDescription {
        //guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {

        guard let context = userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: context) else {
            fatalError(CoreDataError.noEntity(name).error)
        }
        return entity
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
