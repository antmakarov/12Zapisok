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
    
    // MARK: Outlets
    
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
    
    // MARK: Private / Public variables

    var viewModel: GameNoteViewModeling?
    
    private var hintButtons: [UIButton: HintType] = [:]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Setup UI
    
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
            statusHeaderImage.image = Asset.Icons.NoteState.successState.image
            
            placeLabel.text = viewModel.address
            timeFindedLabel.text = Constants.openText + viewModel.openTime
            
        case .progress:
            confiureButton(button: manualInputButton, hintType: .foreverCoordinates)
            confiureButton(button: onMapButton, hintType: .showPlaceOnMap)
            confiureButton(button: distanceButton, hintType: .foreverDistance)
            confiureButton(button: openNoteButton, hintType: .openSingleNote)
            
            noteImage.image = Asset.Icons.AppIcons.compass.image
            statusHeaderImage.image = Asset.Icons.NoteState.progressState.image
            
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
            
            noteImage.image = Asset.Icons.unavailableIcon.image
            statusHeaderImage.image = Asset.Icons.NoteState.closeState.image
            
            placeLabel.text = Constants.unknownPlace
            timeFindedLabel.text = Constants.asSoonTime
        }
    }
    
    private func confiureButton(button: UIButton, hintType: HintType) {
        let hintCount = viewModel?.getCountOfHints(type: hintType) ?? 0
        hintButtons[button] = hintType
        button.setBackground(hintCount > 0 ? Asset.Icons.rectangle.image : nil)
    }
    
    // MARK: Actions
    
    @IBAction private func checkPlace(_ sender: Any) {
        checkForOpenPlace()
    }
    
    @IBAction private func openMap(_ sender: UIButton) {
        preparingHintPopUp(for: sender)
    }
    
    @IBAction private func openNote(_ sender: UIButton) {
        preparingHintPopUp(for: sender, popUp: .openNote)
    }
    
    @IBAction private func showDistance(_ sender: UIButton) {
        preparingHintPopUp(for: sender, popUp: .checkDistance)
    }
    
    @IBAction private func showManualInput(_ sender: UIButton) {
        preparingHintPopUp(for: sender, popUp: .manualCoordinates)
    }
    
    @IBAction private func closeView(_ sender: Any) {
        viewModel?.routeTo?(.back)
    }
    
    // MARK: PopUp Handling
    
    private func showConfirmPopUp(count: Int, completion: @escaping (() -> Void)) {
        showPopUp(type: .commonPopUp(title: "Использовать подсказку?", description: "У вас осталась \(count) подсказка этого типа", fButton: "Да", sButton: "Передумал", fHandler: {
            completion()
        }, sHandler: { [weak self] in
            self?.dismissPopUp()
        }))
    }
    
    private func preparingHintPopUp(for button: UIButton, popUp: PopUpType? = nil) {
        if let hint = hintButtons[button], let count = viewModel?.getCountOfHints(type: hint) {
            if count < 1 {
                showBuyHint()
            } else {
                showConfirmPopUp(count: count) { [weak self] in
                    if hint == .showPlaceOnMap {
                        self?.dismissPopUp()
                        self?.viewModel?.routeTo?(.map)
                    } else {
                        if let popUp = popUp {
                            self?.showPopUp(type: popUp)
                        }
                    }
                }
            }
        }
    }
    
    private func showBuyHint() {
        showPopUp(type: .buyHint { type in
            switch type {
            case .buy:
                Logger.info(msg: "Tap Buy Hint Button")
                
            case .showAd:
                Logger.info(msg: "Tap Show Ad Button")
                
            case .close:
                self.dismissPopUp()
            }
        })
    }
    
    private func checkForOpenPlace() {
        viewModel?.completeNote { [weak self] response in
            switch response {
            case let .success(status):
                if status {
                    self?.showPopUp(type: .commonPopUp(title: "Поздравляем", description: "Очередная записка за Вашими плечами", fButton: "Продолжить") { [weak self] in
                        self?.dismissPopUp()
                        self?.setupUI()
                    })
                } else {
                    self?.showPopUp(type: .commonPopUp(title: "Увы", description: "Но уже близко", fButton: "Продолжить") { [weak self] in
                        self?.dismissPopUp()
                    })
                }
            case .error:
                Logger.error(msg: "Баннер с ошибкой")
            }
        }
    }
}
