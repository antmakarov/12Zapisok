//
//  Note.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import CoreData

final class Note: NSManagedObject, Codable {

    // MARK: - Core Data Properties

    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var details: String
    @NSManaged var address: String
    @NSManaged var location: Location?
    @NSManaged var hint: String
    @NSManaged var statistics: NoteStatistics?
    @NSManaged var category: String
    @NSManaged var imageUrl: String
    @NSManaged var cityID: Int

    // MARK: - Codable Init

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.managedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }

        self.init(context: context)
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            details = try values.decode(String.self, forKey: .details)
            address = try values.decode(String.self, forKey: .address)
            location = try values.decode(Location.self, forKey: .location)
            hint = try values.decode(String.self, forKey: .hint)
            statistics = try values.decodeIfPresent(NoteStatistics.self, forKey: .statistics)
            category = try values.decode(String.self, forKey: .category)
            imageUrl = try values.decode(String.self, forKey: .imageUrl)
            cityID = try values.decode(Int.self, forKey: .cityID)
        } catch {
            Logger.error(msg: error)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(address, forKey: .address)
            try container.encode(hint, forKey: .hint)
            try container.encode(statistics, forKey: .statistics)
            try container.encode(category, forKey: .category)
            try container.encode(details, forKey: .details)
            try container.encode(location, forKey: .location)
            try container.encode(imageUrl, forKey: .imageUrl)
            try container.encode(cityID, forKey: .cityID)
        } catch {
            Logger.error(msg: error)
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, address, hint, category
        case statistics = "statistic"
        case details = "description"
        case location = "point"
        case imageUrl = "image_url"
        case cityID = "town_id"
    }
}
