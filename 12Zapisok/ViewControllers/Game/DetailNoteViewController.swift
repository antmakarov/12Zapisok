//
//  DetailNoteViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class DetailNoteViewController: UIViewController {

    var viewModel: DetailNoteViewModelProtocol?
    
    @IBOutlet weak var numberNoteLabel: UILabel!
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var describLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeFindedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else { return }
        
        numberNoteLabel.text = "Записка #\(viewModel.note.id)"
        titleNoteLabel.text = viewModel.note.name
        describLabel.text = viewModel.note.description
        
        if viewModel.note.isOpen {
            statusImage.image = UIImage(named: "checked")
            placeLabel.text = "Какая-то улица из записки"
            timeFindedLabel.text = "Открыта сегодня в 10:31"
        } else {
            statusImage.image = UIImage(named: "cancel")
            placeLabel.text = "Место неизвестно"
            timeFindedLabel.text = "Найди как можно скорее"
        }
    }
    
    @IBAction func openMap(_ sender: Any) {
        
    }
    
    @IBAction func closeModalView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
