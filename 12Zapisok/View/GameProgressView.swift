//
//  GameProgressView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.05.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class GameProgresView: UIView {
    
    private let notesStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func fillStack() {
        for _ in 0..<12 {
            let stateView = UIImageView()
            stateView.backgroundColor = .clear
            stateView.image = UIImage(named: "greenSmallNote")
            stateView.contentMode = .scaleAspectFit
            
            stateView.translatesAutoresizingMaskIntoConstraints = false
            stateView.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
            notesStack.addArrangedSubview(stateView)
        }
    }
    
    func configure() {
        addSubview(notesStack)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notesStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesStack.topAnchor.constraint(equalTo: topAnchor),
            notesStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            notesStack.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        fillStack()

    }
}

