//
//  CityInfoViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation
 
protocol CityInfoViewModeling {
    var closeButtonPressed: (() -> Void)? { get set }
}

class CityInfoViewModel {
    var closeButtonPressed: (() -> Void)? 

}

extension CityInfoViewModel: CityInfoViewModeling {
    
}
