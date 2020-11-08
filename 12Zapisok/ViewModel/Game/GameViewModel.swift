//
//  GameViewModel.swift
//  12Zapisok
//
//  Created by A.Makarov on 08/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

protocol GameViewModeling {
    func cityName() -> String
    func noteCell(at index: Int) -> NoteCollectionCellViewModel
    func selectNoteDetails(at index: Int)
    func numberOfNotes() -> Int
    func numberOfOpensNotes() -> Int
    func setUpdateHandler(_ handler: (() -> Void)?)
    func loadNotes()

    var routeTo: ((GameRouter) -> Void)? { get set }
    var isLoading: Observable<Bool> { get }
}

final class GameViewModel {

    // MARK: Managers
    private let preferencesManager: PreferencesManager
    private let databaseStorage: StorageManager
    private let networkManager: NetworkManaging
    
    // MARK: Private / Public variables
    private var currentCityName: String?
    private var gameNotes = [Note]()
    private var dataUpdateHandler: (() -> Void)?
    private var dataUpdater = Observable(0)

    public var routeTo: ((GameRouter) -> Void)?
    public var isLoading = Observable<Bool>(false)

    convenience init(cityName: String?) {
        self.init(cityName: cityName, preferencesManager: PreferencesManager.shared, databaseStorage: StorageManager.shared, networkManager: NetworkManager.shared)
    }
    
    init(cityName: String?, preferencesManager: PreferencesManager, databaseStorage: StorageManager, networkManager: NetworkManaging) {
        self.preferencesManager = preferencesManager
        self.databaseStorage = databaseStorage
        self.networkManager = networkManager
        currentCityName = cityName
        
        dataUpdater.addObserver { [weak self] noteId in
            if let index = self?.gameNotes.firstIndex(where: { $0.id == noteId }) {
                self?.gameNotes[index].statistics?.isComplete = true
                self?.gameNotes[index + 1].statistics = NoteStatistics()
                self?.gameNotes[index + 1].statistics?.isOpen = true
                self?.dataUpdateHandler?()
            } else {
                self?.loadNotes()
            }
        }        
    }
}

extension GameViewModel: GameViewModeling {
    public func loadNotes() {
        guard let cityID = preferencesManager.currentCityId else {
            Logger.error(msg: "Unable to get id of current city")
            return
        }
    
        isLoading.value = true
        if let gameNotes = databaseStorage.getObjects(Note.self) {
            self.gameNotes = gameNotes
            dataUpdateHandler?()
        }
        
        networkManager.getNoteList(parameters: ["town_id": cityID]) { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let notes):
                self?.gameNotes = notes
                try? self?.databaseStorage.storeObjects(notes)
                if let note = notes.first, note.statistics == nil {
                    self?.gameNotes.first?.statistics = NoteStatistics(isOpen: true)
                    self?.networkManager.openNote(id: note.id) { _ in }
                }
                self?.dataUpdateHandler?()
            
            case .error(let error):
                Logger.error(msg: error.localizedDescription)
                if let notes = self?.databaseStorage.getObjects(Note.self) {
                    Logger.error(msg: "Loaded from Realm Storage")
                    self?.gameNotes = notes
                    self?.dataUpdateHandler?()
                }
            }
        }
    }

    public func cityName() -> String {
        return currentCityName ?? .empty
    }

    public func noteCell(at index: Int) -> NoteCollectionCellViewModel {
        return NoteCollectionCellViewModel(note: gameNotes[index])
    }
    
    public func selectNoteDetails(at index: Int) {
        let selectedViewModel = GameNoteViewModel(note: gameNotes[index], observer: dataUpdater)
        routeTo?(.note(viewModel: selectedViewModel))
    }
    
    public func numberOfNotes() -> Int {
        return gameNotes.count
    }
    
    public func numberOfOpensNotes() -> Int {
        return gameNotes.compactMap { $0.statistics }.filter { $0.isComplete }.count
    }
    
    public func setUpdateHandler(_ handler: (() -> Void)?) {
        dataUpdateHandler = handler
    }
}
