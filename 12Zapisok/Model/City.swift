//
//  City.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import CoreData

final class City: NSManagedObject, Codable, Identifiable {

    // MARK: - Core Data Properties

    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var imageUrl: String
    @NSManaged var details: CityDetails?
    @NSManaged var location: Location?

    // MARK: - Codable Init

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.managedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }
        
        self.init(context: context)
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            imageUrl = try values.decode(String.self, forKey: .imageUrl)
            details = try values.decodeIfPresent(CityDetails.self, forKey: .details)
            location = try values.decodeIfPresent(Location.self, forKey: .location)
        } catch {
            Logger.error(msg: error)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(imageUrl, forKey: .imageUrl)
            try container.encode(details, forKey: .details)
            try container.encode(location, forKey: .location)
        } catch {
            Logger.error(msg: error)
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case details = "town_info"
        case location = "point"
        case imageUrl = "image_url"
    }
}
