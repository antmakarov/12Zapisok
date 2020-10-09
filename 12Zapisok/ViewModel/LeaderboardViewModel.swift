//
//  LeaderboardViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

protocol LeaderboardViewModeling: AnyObject {
    var closeButtonPressed: (() -> Void)? { get set }
}

final class LeaderboardViewModel {
    public var closeButtonPressed: (() -> Void)?

}

extension LeaderboardViewModel: LeaderboardViewModeling {
    
}
