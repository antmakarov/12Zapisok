//
//  PurchaseViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 16.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    
    @IBOutlet weak var openSingleNoteView: UIView!
    @IBOutlet weak var distanceSingleNoteView: UIView!
    @IBOutlet weak var distanceAllNotesView: UIView!
    @IBOutlet weak var showPinNoteView: UIView!
    @IBOutlet weak var enterAddressView: UIView!
    
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
        view.addShadow(color: UIColor.black.withAlphaComponent(0.35))
    }
    
    //MARK: Actions
    @objc private func openSingleNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .openSingleNote, name: "Открыть одну записку")
    }
    
    @objc private func distanceSingleNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .singleNoteDistance, name: "Расстояние до одной записки")
    }
    
    @objc private func distanceAllNotes(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .foreverDistance, name: "До всех записок навсегда")
    }
    
    @objc private func showPinNote(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .showPlaceOnMap, name: "Показать точку на карте")
    }
    
    @objc private func enterAddress(_ sender: UITapGestureRecognizer) {
        prepareForPopUp(hint: .foreverCoordinates, name: "Возможность вводить адрес без посещения")
    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
    
    private func prepareForPopUp(hint: HintType, name: String) {
        showPopUp(type: .commonPopUp(title: name, description: "Вы уверены, что хотите купить эту подсказку", fButton: "Да", sButton: "Нет", fHandler: { [weak self] in
            self?.viewModel?.buyHint(type: hint)
            self?.showPopUp(type: .commonPopUp(title: "Поздравляю"))
        }, sHandler: { [weak self] in
            self?.dismissPopUp()
        }))
    }
    
    @IBAction func restoreButtonPressed() {
        Logger.info(msg: "Восстановить покупки")
    }
}
