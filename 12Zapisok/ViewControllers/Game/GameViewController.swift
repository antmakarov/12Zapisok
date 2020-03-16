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
    
    var viewModel: GameViewModel?
    
    override func viewDidLayoutSubviews() {
        headerNotesView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16.0)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = GameViewModel()
        
        viewModel?.setUpdateHandler { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.notesCollectionView.reloadData()
        }
        
        notesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 2))
        
        notesCollectionView.register(cellType: NoteCollectionCell.self) 
        notesCollectionView.register(reusableViewType: GameFooterReusableView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        
        if identifier == "detailSegue" {
            if let dvc = segue.destination as? DetailNoteViewController {
                dvc.viewModel = viewModel.viewModelForSelectedNote()
            }
        }
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfCards() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel else {
            fatalError("Not installed View Model")
        }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        let cell = notesCollectionView.dequeueReusableCell(with: NoteCollectionCell.self, for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectNote(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            
            return collectionView.dequeueReusableView(with: GameFooterReusableView.self, for: indexPath, ofKind: kind)
            
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: notesCollectionView.frame.width, height: 75.0)
    }
}
