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
    
    public func fillStack(opensCount: Int) {
        for index in 0..<12 {
            let stateView = UIImageView()
            stateView.backgroundColor = .clear
            
            if opensCount < index {
                stateView.image = UIImage(named: "graySmallNote")
            } else if opensCount == index {
                stateView.image = UIImage(named: "orangeSmallNote")
            } else {
                stateView.image = UIImage(named: "greenSmallNote")
            }
            
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
    }
}

