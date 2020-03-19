//
//  CityInfoViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

enum CityInfoRoute {
    case map
    case back
}

protocol CityInfoViewModeling {
    var routeTo: ((CityInfoRoute) -> Void)? { get set }
}

class CityInfoViewModel {
    var routeTo: ((CityInfoRoute) -> Void)?

}

extension CityInfoViewModel: CityInfoViewModeling {
    
}
