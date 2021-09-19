//
//  NoteStatistics.swift
//  12Zapisok
//
//  Created by Anton Makarov on 24.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import CoreData

final class NoteStatistics: NSManagedObject, Codable {

    // MARK: - Core Data Properties

    @NSManaged var isOpen: Bool
    @NSManaged var isCompleted: Bool
    @NSManaged var timeOpen: String?
    @NSManaged var timeCompleted: String?
    @NSManaged var attempts: Int

    // MARK: - Codable Init

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.managedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }

        self.init(context: context)
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            isOpen = try values.decode(Bool.self, forKey: .isOpen)
            isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
            timeOpen = try values.decodeIfPresent(String.self, forKey: .timeOpen)
            timeCompleted = try values.decodeIfPresent(String.self, forKey: .timeCompleted)
            attempts = try values.decode(Int.self, forKey: .attempts)
        } catch {
            Logger.error(msg: error)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(isOpen, forKey: .isOpen)
            try container.encode(isCompleted, forKey: .isCompleted)
            try container.encode(timeOpen, forKey: .timeOpen)
            try container.encode(timeCompleted, forKey: .timeCompleted)
            try container.encode(attempts, forKey: .attempts)
        } catch {
            Logger.error(msg: error)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case isOpen = "is_open"
        case isCompleted = "is_completed"
        case timeOpen = "open_at"
        case timeCompleted = "completed_at"
        case attempts
    }
}
