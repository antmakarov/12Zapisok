//
//  GameViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController {
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var headerNotesView: UIView!
    @IBOutlet private weak var notesCollectionView: UICollectionView!
    @IBOutlet private weak var backgroundWhiteView: UIView!
    @IBOutlet private weak var gameProgressView: GameProgresView!
    
    var viewModel: GameViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                self?.notesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundWhiteView.roundCorners(corners: [.topLeft, .topRight], radius: 16.0)

        notesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 2))
        notesCollectionView.register(cellType: NoteCollectionCell.self) 
        
        cityNameLabel.text = viewModel?.cityName()
        
        gameProgressView.fillStack(opensCount: viewModel?.numberOfOpensNotes() ?? 0)
    }
    
    @IBAction func openMap() {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction func backButtonPressed() {
        viewModel?.routeTo?(.back)
    }
}

//MARK: UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {
    
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
}

//MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }
        viewModel.selectNoteDetails(at: indexPath.row)
    }
}
