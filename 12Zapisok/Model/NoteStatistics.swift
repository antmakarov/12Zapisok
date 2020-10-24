//
//  NoteStatistics.swift
//  12Zapisok
//
//  Created by Anton Makarov on 24.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import RealmSwift
import ObjectMapper

final class NoteStatistics: Object, Mappable {
    
    @objc dynamic var isOpen: Bool = false
    @objc dynamic var isComplete: Bool = false
    @objc dynamic var attempts: Int = 0
    @objc dynamic var timeOpen: String?
    @objc dynamic var timeCompleted: String?

    convenience init(isOpen: Bool, isComplete: Bool = false) {
        self.init()
        self.isOpen = isOpen
        self.isComplete = isComplete
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        isOpen          <- map["is_open"]
        isComplete      <- map["is_complete"]
        attempts        <- map["attempts"]
        timeOpen        <- map["open_at"]
        timeCompleted   <- map["completed_at"]
    }
}
