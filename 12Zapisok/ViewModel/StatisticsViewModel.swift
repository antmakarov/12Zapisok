//
//  StatisticsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation
import Combine

enum ScreenErrorType {
    case empty
    case error
}

enum StatisticsRoute {
    case game
    case back
}

protocol StatisticsViewModeling: AnyObject {
    func sectionsCount() -> Int
    func getSection(at index: Int) -> StatisticsSections
    func fetchStatistics()
    
    var isLoading: Observable<Bool> { get }
    var screenError: Observable<ScreenErrorType?> { get }
    var successUpdate: Observable<Bool> { get }

    var routeTo: ((StatisticsRoute) -> Void)? { get set }
}

final class StatisticsViewModel {
    
    // MARK: Private

    private let databaseStorage: CoreDataManager
    private let networkManager: NetworkManaging
    
    private var sections: [StatisticsSections] = []
    private var subscription = Set<AnyCancellable>()

    // MARK: Public

    public var routeTo: ((StatisticsRoute) -> Void)?
    public var isLoading = Observable(false)
    public var successUpdate = Observable(false)
    public var screenError = Observable<ScreenErrorType?>(nil)

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
        networkManager.getGameStats()
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.screenError.value = .error
                    Logger.error(msg: error)

                case .finished:
                    self.isLoading.value = false
                    Logger.mark()
                }

            } receiveValue: { value in
                self.screenError.value = nil

                if value.citiesStats.isEmpty == false {
                    self.screenError.value = nil
                    self.sections.append(.header(total: value.totalScore,
                                                 notes: value.openNotes,
                                                 attemps: value.totalAttempts) )
                    self.sections.append(.title)

                    value.citiesStats.forEach {
                        self.sections.append(.city(stats: $0))
                    }
                    self.successUpdate.value = true
                } else {
                    self.screenError.value = .empty
                }
                //self.responseStatus.value = value.citiesStats?.isEmpty == true ? .empty : .success
            }
            .store(in: &self.subscription)
    }

    private func processError(_ error: Error) {

    }

    public func sectionsCount() -> Int {
        return sections.count
    }
    
    public func getSection(at index: Int) -> StatisticsSections {
        return sections[index]
    }
}
