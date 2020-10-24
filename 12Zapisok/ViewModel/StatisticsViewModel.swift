//
//  StatisticsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

enum StatisticsRoute {
    case game
    case back
}

protocol StatisticsViewModeling: AnyObject {
    func sectionsCount() -> Int
    func getSection(at index: Int) -> StatisticsSections
    func fetchStatistics()
    
    var responseStatus: Observable<ResponseStatus> { get }
    var isLoading: Observable<Bool> { get }

    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class StatisticsViewModel {
    
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    private var sections: [StatisticsSections] = []
    
    var routeTo: ((StatisticsRoute) -> Void)?
    public var responseStatus = Observable<ResponseStatus>(value: .empty)
    public var isLoading = Observable<Bool>(value: false)
    
    convenience init() {
        self.init(databaseStorage: StorageManager.shared,
                  networkManager: NetworkManager.shared)
    }
    
    init(databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager        
    }
}

extension StatisticsViewModel: StatisticsViewModeling {
    
    public func fetchStatistics() {
        isLoading.value = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.networkManager.getGameStats { [weak self] result in
                self?.isLoading.value = false

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
                    self?.responseStatus.value = response.citiesStats?.isEmpty == true ? .empty : .success
                    
                case let .error(error):
                    self?.responseStatus.value = .error
                    Logger.error(msg: error)
                }
            }
        }
    }
    
    public func sectionsCount() -> Int {
        return sections.count
    }
    
    public func getSection(at index: Int) -> StatisticsSections {
        return sections[index]
    }
}
