//
//  GameLeaders.swift
//  12Zapisok
//
//  Created by Anton Makarov on 11.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

final class GameLeaders: Object, Mappable {
    
    @objc dynamic var id = UUID().uuidString
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
    }
    
    static func url() -> String {
        return "/leaders"
    }
}
