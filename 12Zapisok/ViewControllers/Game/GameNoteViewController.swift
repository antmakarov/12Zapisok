//
//  GameNoteViewController.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

class GameNoteViewController: BaseViewController {
    
    var viewModel: GameNoteViewModeling?
    
    @IBOutlet weak var numberNoteLabel: UILabel!
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var describLabel: UILabel!
    @IBOutlet weak var statusHeaderImage: UIImageView!
    
    @IBOutlet weak var addressStackView: UIStackView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeFindedLabel: UILabel!
    
    @IBOutlet weak var hintsStackView: UIStackView!
    @IBOutlet weak var openNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        
        numberNoteLabel.text = "Записка #\(viewModel.id)"
        titleNoteLabel.text = viewModel.title
        describLabel.text = viewModel.description
        
        switch viewModel.state {
        case .open:
            openNoteButton.isHidden = true
            statusHeaderImage.image = UIImage(named: "checked")
            placeLabel.text = "Какая-то улица из записки"
            timeFindedLabel.text = "Открыта сегодня в 10:31"
            
        case .progress:
            statusHeaderImage.image = UIImage(named: "cancel")
            placeLabel.text = "Место неизвестно"
            timeFindedLabel.text = "Найди как можно скорее"
            
        case .close:
            statusHeaderImage.image = UIImage(named: "cancel")
            placeLabel.text = "Место неизвестно"
            timeFindedLabel.text = "Найди как можно скорее"
        }
    }
    
    @IBAction func openNote(_ sender: Any) {
        viewModel?.openNote(completion: { result in
            print(result)
        })
    }
    
    @IBAction func openMap(_ sender: Any) {
        viewModel?.routeTo?(.map)
    }
    
    @IBAction func closeView(_ sender: Any) {
        viewModel?.routeTo?(.back)
    }
}
