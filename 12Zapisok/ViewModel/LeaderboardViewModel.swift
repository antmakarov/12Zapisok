//
//  LeaderboardViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

protocol LeaderboardViewModeling: class {
    var closeButtonPressed: (() -> Void)? { get set }
}

class LeaderboardViewModel {
    public var closeButtonPressed: (() -> Void)?

}

extension LeaderboardViewModel: LeaderboardViewModeling {
    
}
