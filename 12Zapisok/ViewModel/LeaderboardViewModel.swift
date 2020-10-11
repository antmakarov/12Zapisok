//
//  LeaderboardViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

protocol LeaderboardViewModeling: AnyObject {
    func usersCount() -> Int
    func getUser(at index: Int) -> String
    func setUpdateHandler(_ handler: (() -> Void)?)
    func fetchLeaders()
        
    var closeButtonPressed: (() -> Void)? { get set }
}

final class LeaderboardViewModel {
    
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging

    private var leaders: [GameLeaders] = []
    private var updateHandler: (() -> Void)?
    
    public var closeButtonPressed: (() -> Void)?
    
    convenience init() {
        self.init(databaseStorage: StorageManager.shared,
                  networkManager: NetworkManager.shared)
    }
    
    init(databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        
        fetchLeaders()
    }
}

extension LeaderboardViewModel: LeaderboardViewModeling {
    func usersCount() -> Int {
        return 5 //leaders.count
    }
    
    func getUser(at index: Int) -> String {
        return "Test" // leaders[index].id
    }
    
    func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    func fetchLeaders() {
        
    }
}
