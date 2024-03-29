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
        static let openText = Localized.open
        static let unknownPlace = Localized.locationUnknown
        static let asSoonTime = Localized.findAsSoon
        
        static let shadowOpacity: Float = 0.1
        static let shadowOffset = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 3
        static let shadowColor: UIColor = .black
    }
    // MARK: Outlets
    
    @IBOutlet private weak var numberNoteLabel: UILabel!
    @IBOutlet private weak var titleNoteLabel: UILabel!
    @IBOutlet private weak var describLabel: UILabel!
    @IBOutlet private weak var statusHeaderView: UIView!
    
    @IBOutlet private weak var noteImage: UIImageView!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
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
        
        numberNoteLabel.text = Localized.noteNumber(String(viewModel.id))
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
            noteImage.rounded(cornerRadius: 8.0)
            statusHeaderView.backgroundColor = .AppMainDark
            
            addressLabel.text = viewModel.address
            timeLabel.text = Constants.openText + viewModel.openTime
            
        case .progress:
            confiureButton(button: manualInputButton, hintType: .foreverCoordinates)
            confiureButton(button: onMapButton, hintType: .showPlaceOnMap)
            confiureButton(button: distanceButton, hintType: .foreverDistance)
            confiureButton(button: openNoteButton, hintType: .openSingleNote)
            
            noteImage.image = Asset.Icons.AppIcons.compass.image
            statusHeaderView.backgroundColor = .AppOrange

            addressLabel.text = Constants.unknownPlace
            timeLabel.text = Constants.asSoonTime
            hintStatusLabel.text = viewModel.getDistanceStatus() // "Пока все еще холодно"
            
        case .close:
            hintsStackView.isHidden = true
            openNoteButton.isHidden = true
            addressStackView.isHidden = false
            checkNoteButton.isHidden = true
            hintLabel.isHidden = true
            hintStatusLabel.isHidden = true
            
            noteImage.image = Asset.Icons.unavailableIcon.image
            statusHeaderView.backgroundColor = .AppGray

            addressLabel.text = Constants.unknownPlace
            timeLabel.text = Constants.asSoonTime
        }
    }
    
    private func confiureButton(button: UIButton, hintType: HintType) {
        let isAlreadyHintOpen = viewModel?.isAlreadyHintOpen(type: hintType) ?? false
        let hintCount = viewModel?.getCountOfHints(type: hintType) ?? 0
        hintButtons[button] = hintType
        button.backgroundColor = (hintCount > 0 || isAlreadyHintOpen) ? .AppMain : .AppGray
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
        showPopUp(type: .commonPopUp(title: Localized.hintUse, description: "У вас осталась \(count) подсказка этого типа", fButton: Localized.yes, sButton: Localized.changeMind, fHandler: {
            completion()
        }, sHandler: { [weak self] in
            self?.dismissPopUp()
        }))
    }
    
    private func preparingHintPopUp(for button: UIButton, popUp: PopUpType? = nil) {
        if let hint = hintButtons[button] {
            let isAlreadyHintOpen = viewModel?.isAlreadyHintOpen(type: hint) ?? false
            let hintCount = viewModel?.getCountOfHints(type: hint) ?? 0
            if hintCount == 0 && isAlreadyHintOpen == false {
                showBuyHint()
            } else {
                if isAlreadyHintOpen {
                    if hint == .showPlaceOnMap {
                        dismissPopUp()
                        viewModel?.routeTo?(.map)
                    } else if let popUp = popUp {
                        showPopUp(type: popUp)
                    }
                } else {
                    showConfirmPopUp(count: hintCount) { [weak self] in
                        self?.viewModel?.openHint(type: hint)
                        if hint == .showPlaceOnMap {
                            self?.dismissPopUp()
                            self?.viewModel?.routeTo?(.map)
                        } else if hint == .openSingleNote {
                            self?.viewModel?.completeNote { _ in
                                self?.dismissPopUp()
                                self?.setupUI()
                            }
                        } else {
                            if let popUp = popUp {
                                self?.showPopUp(type: popUp)
                            }
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
        viewModel?.completeNoteWithCheck { [weak self] response in
            switch response {
            case let .success(status):
                if status {
                    self?.showPopUp(type: .commonPopUp(title: Localized.congrats, description: Localized.hintOpen, fButton: Localized.continue) { [weak self] in
                        self?.dismissPopUp()
                        self?.setupUI()
                    })
                } else {
                    self?.showPopUp(type: .commonPopUp(title: Localized.sorry, description: Localized.hintAlreadyClose, fButton: Localized.continue) { [weak self] in
                        self?.dismissPopUp()
                    })
                }
            case .error:
                Logger.error(msg: "Баннер с ошибкой")
            }
        }
    }
}
