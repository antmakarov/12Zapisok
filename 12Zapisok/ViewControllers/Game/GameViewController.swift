//
//  GameViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class GameViewController: BaseViewController {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16.0
    }

    // MARK: Outlets

    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var headerNotesView: UIView!
    @IBOutlet private weak var notesCollectionView: UICollectionView!
    @IBOutlet private weak var backgroundWhiteView: UIView!
    @IBOutlet private weak var gameProgressView: GameProgresView!
    
    // MARK: Private / Public variables

    var viewModel: GameViewModeling? {
        didSet {
//            viewModel?.setUpdateHandler { [weak self] in
//                self?.gameProgressView.fillStack(opensCount: self?.viewModel?.numberOfOpensNotes() ?? 0)
//                self?.notesCollectionView.reloadData()
//            }
            
            viewModel?.isLoading.addObserver { [weak self] in
                self?.toggleLoader($0)
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.loadNotes()
        notesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 2))
        
        notesCollectionView.register(reusableViewType: GameFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        notesCollectionView.register(cellType: NoteCollectionCell.self) 
        
        cityNameLabel.text = viewModel?.cityName()
        gameProgressView.fillStack(opensCount: viewModel?.numberOfOpensNotes() ?? 0)
        backgroundWhiteView.roundCorners(corners: [.topLeft, .topRight], radius: Constants.cornerRadius)
    }
    
    // MARK: Actions
    
    @IBAction private func openMap() {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction private func backButtonPressed() {
        viewModel?.routeTo?(.back)
    }
    
    @IBAction private func resetCityProgress() {
        
    }
    
    @IBAction private func openAllNotes() {
        
    }
}

// MARK: UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfNotes() != 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfNotes() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }

        let noteViewModel = viewModel.noteCell(at: indexPath.row)
        let cell = notesCollectionView.dequeueReusableCell(with: NoteCollectionCell.self, for: indexPath)
        cell.configure(viewModel: noteViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            
            let headerView = collectionView.dequeueReusableView(with: GameFooterView.self, for: indexPath, ofKind: UICollectionView.elementKindSectionFooter)
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        viewModel.selectNoteDetails(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50.0)
    }
}
