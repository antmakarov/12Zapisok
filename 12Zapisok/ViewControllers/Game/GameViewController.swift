//
//  GameViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController {
    
    @IBOutlet weak var headerNotesView: UIView!
    @IBOutlet weak var notesCollectionView: UICollectionView!
    
    var viewModel: GameViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                self?.notesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerNotesView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16.0)

        notesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 2))
        notesCollectionView.register(cellType: NoteCollectionCell.self) 
        notesCollectionView.register(reusableViewType: GameFooterReusableView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
    
    @IBAction func backButtonPressed() {
        viewModel?.finishFlow()
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            
            return collectionView.dequeueReusableView(with: GameFooterReusableView.self, for: indexPath, ofKind: kind)
            
        default:
            assert(false, "Invalid element type")
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: notesCollectionView.frame.width, height: 75.0)
    }
}
