//
//  LeaderboardViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation
import Combine

protocol LeaderboardViewModeling: ObservableObject {
    func usersCount() -> Int
    func getUser(at index: Int) -> String
    func fetchLeaders()

    var isLoading: Observable<Bool> { get }
    var dataType: Observable<ResponseDataType> { get }

    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class LeaderboardViewModel {
    
    // MARK: Private
    
    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging

    private var leaders: [GameLeader] = []
    private var subscription = Set<AnyCancellable>()

    // MARK: Public
    
    public var routeTo: ((StatisticsRoute) -> Void)?
    public var isLoading = Observable<Bool>(false)
    public var dataType = Observable<ResponseDataType>(.empty)

    // MARK: Lifecycle

    convenience init() {
        self.init(databaseStorage: CoreDataManager.shared,
                  networkManager: NetworkManager.shared)
    }
    
    init(databaseStorage: CoreDataManager, networkManager: NetworkManaging) {
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
    }
}

// MARK: LeaderboardViewModeling

extension LeaderboardViewModel: LeaderboardViewModeling {
    public func usersCount() -> Int {
        return leaders.count
    }
    
    public func getUser(at index: Int) -> String {
        return "" //leaders[index].userId
    }
    
    public func fetchLeaders() {
        isLoading.value = true
        networkManager.getGameLeaders()
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    Logger.error(msg: error)
                    self.dataType.value = .error
                    fallthrough

                case .finished:
                    self.isLoading.value = false
                }
            } receiveValue: { value in
                if !value.isEmpty {
                    self.dataType.value = .success
                } else {
                    self.dataType.value = .empty
                }
            }
            .store(in: &self.subscription)
    }
}
