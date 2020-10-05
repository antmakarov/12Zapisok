//
//  GameNoteViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit
import SwiftEntryKit

class GameNoteViewController: BaseViewController {
    
    private enum Constants {
        static let noteTitle = "Записка #"
        static let openText = "Открыта "
        static let unknownPlace = "Место неизвестно"
        static let asSoonTime = "Найди как можно скорее"
    }
    
    var viewModel: GameNoteViewModeling?
    
    @IBOutlet private weak var numberNoteLabel: UILabel!
    @IBOutlet private weak var titleNoteLabel: UILabel!
    @IBOutlet private weak var describLabel: UILabel!
    @IBOutlet private weak var statusHeaderImage: UIImageView!
    
    @IBOutlet private weak var noteImage: UIImageView!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var timeFindedLabel: UILabel!
    
    @IBOutlet private weak var hintsStackView: UIStackView!
    @IBOutlet private weak var openNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        
        numberNoteLabel.text = Constants.noteTitle + viewModel.id
        titleNoteLabel.text = viewModel.title
        describLabel.text = viewModel.description
        
        switch viewModel.state {
        case .open:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            
            noteImage.setupImage(url: viewModel.imgUrl, placeholder: .app)
            statusHeaderImage.image = .successState
            
            placeLabel.text = viewModel.address
            timeFindedLabel.text = Constants.openText + viewModel.openTime
            
        case .progress:
            noteImage.image = .progressIcon
            statusHeaderImage.image = .progressState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
            
        case .close:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            
            noteImage.image = .unavailableIcon
            statusHeaderImage.image = .closeState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
        }
    }
    
    @IBAction private func openNote(_ sender: Any) {
        viewModel?.openNote(completion: { result in
            Logger.info(msg: result)
        })
    }
    
    @IBAction private func openMap(_ sender: Any) {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction func showDistance(_ sender: Any) {
        showPopUp(type: .checkDistance)
    }
    
    @IBAction private func closeView(_ sender: Any) {
        viewModel?.routeTo?(.back)
    }
}
