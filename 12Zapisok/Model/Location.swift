//
//  Location.swift
//  12Zapisok
//
//  Created by Anton Makarov on 13.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import CoreData
import CoreLocation

final class Location: NSManagedObject, Codable {

    // MARK: - Core Data Properties

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double

    // MARK: - Public Properties

    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var isNullLocation: Bool {
        latitude == 0 || longitude == 0
    }

    convenience init(coordinate: CLLocationCoordinate2D?) {
        self.init()
        latitude = coordinate?.latitude ?? 0
        longitude = coordinate?.longitude ?? 0
    }

    // MARK: - Codable Init

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.managedObjectContext else {
            fatalError(CoreDataError.noContext.error)
        }

        self.init(context: context)
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            latitude = try values.decode(Double.self, forKey: .lat)
            longitude = try values.decode(Double.self, forKey: .lon)
        } catch {
            Logger.error(msg: error)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(latitude, forKey: .lat)
            try container.encode(longitude, forKey: .lon)
        } catch {
            Logger.error(msg: error)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}
