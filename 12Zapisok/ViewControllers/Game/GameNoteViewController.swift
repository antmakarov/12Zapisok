//
//  GameNoteViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

final class GameNoteViewController: BaseViewController {
    
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
    
    @IBOutlet private weak var checkNoteButton: UIButton!
    @IBOutlet private weak var manualInputButton: UIButton!
    @IBOutlet private weak var onMapButton: UIButton!
    @IBOutlet private weak var distanceButton: UIButton!
    @IBOutlet private weak var openNoteButton: UIButton!
    @IBOutlet private weak var hintsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        numberNoteLabel.text = Constants.noteTitle + viewModel.id
        titleNoteLabel.text = viewModel.title
        describLabel.text = viewModel.description
        
        switch viewModel.state {
        case .open:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            
            noteImage.setupImage(url: viewModel.imgUrl, placeholder: .app)
            statusHeaderImage.image = Asset.Icons.NoteState.successState
            
            placeLabel.text = viewModel.address
            timeFindedLabel.text = Constants.openText + viewModel.openTime
            
        case .progress:
            confiureButton(button: manualInputButton, hintType: .foreverCoordinates)
            confiureButton(button: onMapButton, hintType: .showPlaceOnMap)
            confiureButton(button: distanceButton, hintType: .foreverDistance)
            confiureButton(button: openNoteButton, hintType: .openSingleNote)
            
            noteImage.image = Asset.Icons.progressIcon
            statusHeaderImage.image = Asset.Icons.NoteState.progressState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
            
        case .close:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            
            noteImage.image = Asset.Icons.unavailableIcon
            statusHeaderImage.image = Asset.Icons.NoteState.closeState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
        }
    }
    
    private func confiureButton(button: UIButton, hintType: HintType) {
        guard let hintManager = viewModel?.hintManager else {
            return
        }
        button.setBackground(hintManager.getCountOf(hint: hintType) > 0 ? Asset.Icons.rectangle : nil)
    }
    
    @IBAction private func checkPlace(_ sender: Any) {
        viewModel?.checkPlace { result in
            Logger.info(msg: result)
        }
    }
    
    @IBAction private func openMap(_ sender: Any) {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction private func closeView(_ sender: Any) {
        viewModel?.routeTo?(.back)
    }
    
    @IBAction private func openNote(_ sender: Any) {
        showHint(for: .openNote)
    }
    
    @IBAction private func showDistance(_ sender: Any) {
        showHint(for: .checkDistance)
    }
    
    @IBAction private func showManualInput(_ sender: Any) {
        showHint(for: .manualCoordinates)
    }
    
    private func showHint(for popUpType: PopUpType) {
        showPopUp(type: .hint { type in
            switch type {
            case .apply:
                self.showPopUp(type: popUpType)
                
            case .buy:
                Logger.info(msg: "Tap Buy Hint Button")
                
            case .showAd:
                Logger.info(msg: "Tap Show Ad Button")

            case .close:
                self.dismissPopUp()
            }
        })
    }
}
