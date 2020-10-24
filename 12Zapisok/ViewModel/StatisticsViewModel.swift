//
//  StatisticsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

enum StatisticsRoute {
    case game
    case back
}

protocol StatisticsViewModeling: AnyObject {
    func sectionsCount() -> Int
    func getSection(at index: Int) -> StatisticsSections
    func setUpdateHandler(_ handler: (() -> Void)?)
    func fetchStatistics()
    
    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class StatisticsViewModel {
    
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    private var updateHandler: (() -> Void)?
    private var sections: [StatisticsSections] = []
    
    var routeTo: ((StatisticsRoute) -> Void)?

    convenience init() {
        self.init(databaseStorage: StorageManager.shared,
                  networkManager: NetworkManager.shared)
    }
    
    init(databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        
        fetchStatistics()
    }
}

extension StatisticsViewModel: StatisticsViewModeling {
    
    public func fetchStatistics() {
        
        networkManager.getGameStats { [weak self] result in
            switch result {
            case let .success(response):
                if response.citiesStats?.isEmpty == false {
                    self?.sections.append(.header(total: response.totalScore,
                                                  notes: response.openNotes,
                                                  attemps: response.totalAttempts) )
                    self?.sections.append(.title)
                    
                    response.citiesStats?.forEach {
                        self?.sections.append(.city(stats: $0))
                    }
                }
                
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
            }
            
            self?.updateHandler?()
        }
    }
    
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        updateHandler = handler
    }
    
    public func sectionsCount() -> Int {
        return sections.count
    }
    
    public func getSection(at index: Int) -> StatisticsSections {
        return sections[index]
    }
}
