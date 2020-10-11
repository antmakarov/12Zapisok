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
    @IBOutlet private weak var hintLabel: UILabel!
    @IBOutlet private weak var hintStatusLabel: UILabel!

    @IBOutlet private weak var checkNoteButton: UIButton!
    @IBOutlet private weak var manualInputButton: UIButton!
    @IBOutlet private weak var onMapButton: UIButton!
    @IBOutlet private weak var distanceButton: UIButton!
    @IBOutlet private weak var openNoteButton: UIButton!
    @IBOutlet private weak var hintsStackView: UIStackView!

    private var hintButtons: [UIButton: HintType] = [:]
    
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
            checkNoteButton.isHidden = true
            hintLabel.isHidden = true
            hintStatusLabel.isHidden = true
            
            noteImage.setupImage(url: viewModel.imgUrl, placeholder: .app)
            statusHeaderImage.image = Asset.Icons.NoteState.successState
            
            placeLabel.text = viewModel.address
            timeFindedLabel.text = Constants.openText + viewModel.openTime
            
        case .progress:
            confiureButton(button: manualInputButton, hintType: .foreverCoordinates)
            confiureButton(button: onMapButton, hintType: .showPlaceOnMap)
            confiureButton(button: distanceButton, hintType: .foreverDistance)
            confiureButton(button: openNoteButton, hintType: .openSingleNote)
            
            noteImage.image = Asset.Icons.AppIcons.compass
            statusHeaderImage.image = Asset.Icons.NoteState.progressState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
            hintStatusLabel.text = "Пока все еще холодно"
            
        case .close:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            checkNoteButton.isHidden = true
            hintLabel.isHidden = true
            hintStatusLabel.isHidden = true
            
            noteImage.image = Asset.Icons.unavailableIcon
            statusHeaderImage.image = Asset.Icons.NoteState.closeState
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
        }
    }
    
    private func confiureButton(button: UIButton, hintType: HintType) {
        let hintCount = viewModel?.hintManager.getCountOf(hint: hintType) ?? 0
        hintButtons[button] = hintType
        button.setBackground(hintCount > 0 ? Asset.Icons.rectangle : nil)
    }
    
    @IBAction private func checkPlace(_ sender: Any) {
        viewModel?.checkPlace { [weak self] in
            if $0 {
                self?.showPopUp(type: .commonPopUp(title: "Поздравляем", description: "Очередная записка за Вашими плечами", fButton: "Продолжить") { [weak self] in
                    self?.dismissPopUp()
                    self?.setupUI()
                })
            } else {
                self?.showPopUp(type: .commonPopUp(title: "Увы", description: "Но уже близко", fButton: "Продолжить") { [weak self] in
                    self?.dismissPopUp()
                })
            }
        }
    }
    
    @IBAction private func openMap(_ sender: Any) {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction private func closeView(_ sender: Any) {
        viewModel?.routeTo?(.back)
    }
    
    @IBAction private func openNote(_ sender: Any) {
        checkHintAvailable(for: sender, popUp: .openNote)
    }
    
    @IBAction private func showDistance(_ sender: Any) {
        checkHintAvailable(for: sender, popUp: .checkDistance)
    }
    
    @IBAction private func showManualInput(_ sender: Any) {
        checkHintAvailable(for: sender, popUp: .manualCoordinates)
    }
    
    private func checkHintAvailable(for button: Any, popUp: PopUpType) {
        if let button = button as? UIButton, let hint = hintButtons[button],
           let count = viewModel?.hintManager.getCountOf(hint: hint) {
            if count < 1 {
                showHint(for: popUp)
            } else {
                showPopUp(type: .commonPopUp(title: "Использовать подсказку?", description: "У вас осталась \(count) подсказка этого типа", fButton: "Да", sButton: "Передумал", fHandler: { [weak self] in
                    self?.showPopUp(type: popUp)
                }, sHandler: { [weak self] in
                    self?.dismissPopUp()
                }))
            }
        }
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
