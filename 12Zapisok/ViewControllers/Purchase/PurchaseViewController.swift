//
//  PurchaseViewController.swift
//  12Zapisok
//
//  Created by Anton Makarov on 16.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

private enum PurchaseType {
    case openSingleNote
    case distanceSingleNote
    case distanceAllNotes
    case showPinNote
    case enterAddress
}

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
        print("Buy Open Single Note")
    }
    
    @objc private func distanceSingleNote(_ sender: UITapGestureRecognizer) {
        print("Buy Distance Single Note")
    }
    
    @objc private func distanceAllNotes(_ sender: UITapGestureRecognizer) {
        print("Buy Distance All Notes")
    }
    
    @objc private func showPinNote(_ sender: UITapGestureRecognizer) {
        print("Buy Show Pin Note")
    }
    
    @objc private func enterAddress(_ sender: UITapGestureRecognizer) {
        print("Buy Enter Address")
    }
    
    @IBAction func closeButtonPressed() {
        viewModel?.closeButtonPressed?()
    }
    
    @IBAction func restoreButtonPressed() {
        Logger.info(msg: "Восстановить покупки")
    }
}
