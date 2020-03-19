//
//  MapViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

protocol MapViewModeling: class {
    var closeButtonPressed: (() -> Void)? { get set }
}

class MapViewModel {
    public var closeButtonPressed: (() -> Void)?

}

extension MapViewModel: MapViewModeling {
    
}
