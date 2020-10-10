//
//  StatisticsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

protocol StatisticsViewModeling: AnyObject {
    func sectionsCount() -> Int
    func getSection(at index: Int) -> StatisticsSections
    func setUpdateHandler(_ handler: (() -> Void)?)
    func fetchStatistics()
    
    var closeButtonPressed: (() -> Void)? { get set }
}

final class StatisticsViewModel {
    
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    public var closeButtonPressed: (() -> Void)?
    private var updateHandler: (() -> Void)?

    private var sections: [StatisticsSections] = []
    
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
        
//        if let stats = databaseStorage.getObjects(GameStatistics.self) {
//            return
//        }
        
        networkManager.getGameStats { [weak self] result in
            switch result {
            case .success:
                self?.sections.append(.header)
                self?.sections.append(.title)
                self?.sections.append(.city)
                self?.sections.append(.city)
                self?.updateHandler?()
                
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
                self?.updateHandler?()
            }
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
