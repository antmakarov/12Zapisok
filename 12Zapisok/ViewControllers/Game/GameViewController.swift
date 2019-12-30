//
//  GameViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var headerNotesView: UIView!
    @IBOutlet weak var notesCollectionView: UICollectionView!
    
    var viewModel: GameViewModel?
    
    override func viewDidLayoutSubviews() {
        headerNotesView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16.0)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel?.setDataUpdateHandler { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.notesCollectionView.reloadData()
        }
        
        viewModel = GameViewModel()

        notesCollectionView.collectionViewLayout = GridCollectionViewFlowLayout(display: .grid(columns: 2))
        
        notesCollectionView.register(UINib(nibName: "NoteCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
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
        
        let cell: NoteCollectionCell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionCell
        
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
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
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: notesCollectionView.frame.width, height: 75.0)
    }
}
