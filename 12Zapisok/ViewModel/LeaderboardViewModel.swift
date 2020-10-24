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
        
    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class LeaderboardViewModel {
    
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging

    private var leaders: [GameLeader] = []
    private var updateHandler: (() -> Void)?
    
    public var routeTo: ((StatisticsRoute) -> Void)?

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
        return leaders.count
    }
    
    func getUser(at index: Int) -> String {
        return leaders[index].id
    }
    
    func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    func fetchLeaders() {
        networkManager.getGameLeaders { response in
            switch response {
            case let .success(result):
                Logger.debug(msg: result)
                
            case let .error(error):
                Logger.error(msg: error)
            }
            
            self.updateHandler?()
        }
    }
}
