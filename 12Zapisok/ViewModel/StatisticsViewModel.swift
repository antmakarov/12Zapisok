//
//  StatisticsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

protocol StatisticsViewModeling: class {
    var closeButtonPressed: (() -> Void)? { get set }
}

class StatisticsViewModel {
    public var closeButtonPressed: (() -> Void)?

}

extension StatisticsViewModel: StatisticsViewModeling {
    
}
