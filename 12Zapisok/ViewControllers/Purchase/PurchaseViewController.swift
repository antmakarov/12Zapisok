//
//  PurchaseViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 16.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class PurchaseViewController: UIViewController {
    
    @IBOutlet private weak var openSingleNoteView: UIView!
    @IBOutlet private weak var distanceSingleNoteView: UIView!
    @IBOutlet private weak var distanceAllNotesView: UIView!
    @IBOutlet private weak var showPinNoteView: UIView!
    @IBOutlet private weak var enterAddressView: UIView!
    
    var viewModel: PurchaseViewModeling? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(openSingleNoteView, selector: #selector(PurchaseViewController.openSingleNote(_:)))
        configure(distanceSingleNoteView, selector: #selector(PurchaseViewController.distanceSingleNote(_:)))
        configure(distanceAllNotesView, selector: #selector(PurchaseViewController.distanceAllNotes(_:)))
        configure(showPinNoteView, selector: #selector(PurchaseViewController.showPinNote(_:)))
        configure(enterAddressView, selector: #selector(PurchaseViewController.enterAddress(_:)))
    }
    
    private func configure(_ view: UIView, selector: Selector) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        view.addShadow(color: UIColor.black.withAlphaComponent(0.25))
    }
    
    // MARK: Actions
    @objc
    private func openSingleNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .openSingleNote, name: Localized.hintOpenOne)
    }
    
    @objc
    private func distanceSingleNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .singleNoteDistance, name: Localized.hintDistanceToOne)
    }
    
    @objc
    private func distanceAllNotes(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .foreverDistance, name: Localized.hintDistanceToAll)
    }
    
    @objc
    private func showPinNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .showPlaceOnMap, name: Localized.hintShowMapPin)
    }
    
    @objc
    private func enterAddress(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .foreverCoordinates, name: Localized.hintManualInput)
    }
    
    @IBAction private func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
    
    private func prepareForPopUp(hint: HintType, name: String) {
        showPopUp(type: .commonPopUp(title: name, description: Localized.hintSureToBuy, fButton: Localized.yes, sButton: Localized.no, fHandler: { [weak self] in
            self?.viewModel?.buyHint(type: hint)
            self?.showPopUp(type: .commonPopUp(title: Localized.congrats))
        }, sHandler: { [weak self] in
            self?.dismissPopUp()
        }))
    }
    
    @IBAction private func restoreButtonPressed() {
        Logger.info(msg: Localized.hintRestoreAll)
    }
}
