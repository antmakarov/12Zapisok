//
//  DataFetcher.swift
//  
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol NotesFetchProtocol {
    func fetchNotes(completion: ([Note]?) -> () )
   // func fetchCities(completion: ([Note]?) -> () )
}
