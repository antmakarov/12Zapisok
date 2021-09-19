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
    
    //var responseStatus: Observable<ResponseStatus> { get }
    var isLoading: Observable<Bool> { get }

    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class StatisticsViewModel {
    
    // MARK: Private

    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging
    
    private var sections: [StatisticsSections] = []
    
    // MARK: Public

    public var routeTo: ((StatisticsRoute) -> Void)?
    //public var responseStatus = Observable(ResponseStatus.empty)
    public var isLoading = Observable(false)
    
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

// MARK: StatisticsViewModeling

extension StatisticsViewModel: StatisticsViewModeling {
    
    public func fetchStatistics() {
        isLoading.value = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.networkManager.getGameStats { [weak self] result in
//                self?.isLoading.value = false
//
//                switch result {
//                case let .success(response):
//                    if response.citiesStats?.isEmpty == false {
//                        self?.sections.append(.header(total: response.totalScore,
//                                                      notes: response.openNotes,
//                                                      attemps: response.totalAttempts) )
//                        self?.sections.append(.title)
//                        
//                        response.citiesStats?.forEach {
//                            self?.sections.append(.city(stats: $0))
//                        }
//                    }
//                    self?.responseStatus.value = response.citiesStats?.isEmpty == true ? .empty : .success
//                    
//                case let .error(error):
//                    self?.responseStatus.value = .error
//                    Logger.error(msg: error)
//                }
//            }
//        }
    }
    
    public func sectionsCount() -> Int {
        return sections.count
    }
    
    public func getSection(at index: Int) -> StatisticsSections {
        return sections[index]
    }
}
