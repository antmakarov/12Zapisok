//
//  CityDetails.swift
//  12Zapisok
//
//  Created by Anton Makarov on 03.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import CoreData

final class CityDetails: NSManagedObject, Codable {

    // MARK: - Core Data Properties

    @NSManaged var name: String
    @NSManaged var details: String
    @NSManaged var baseYear: Int
    @NSManaged var population: Int
    @NSManaged var regionCode: Int
    @NSManaged var images: [String]

    // MARK: - Codable Init

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.managedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }
        
        self.init(context: context)
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decode(String.self, forKey: .name)
            details = try values.decode(String.self, forKey: .details)
            baseYear = try values.decodeIfPresent(Int.self, forKey: .baseYear) ?? 0
            population = try values.decodeIfPresent(Int.self, forKey: .population) ?? 0
            regionCode = try values.decodeIfPresent(Int.self, forKey: .regionCode) ?? 0
            images = try values.decode([String].self, forKey: .images)
        } catch {
            Logger.error(msg: error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(name, forKey: .name)
            try container.encode(details, forKey: .details)
            try container.encode(baseYear, forKey: .baseYear)
            try container.encode(population, forKey: .population)
            try container.encode(regionCode, forKey: .regionCode)
            try container.encode(images, forKey: .images)
        } catch {
            Logger.error(msg: error)
        }
    }

    enum CodingKeys: String, CodingKey {
        case name, population
        case details = "full_description"
        case baseYear = "base_year"
        case regionCode = "region_code"
        case images = "image_urls"
    }
}
