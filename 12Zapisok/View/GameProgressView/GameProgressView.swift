//
//  GameProgressView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.05.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

class ProgressDotView: UIView {
    enum Constants {
        static let baseSize: CGFloat = 22
        static let spaceLine: CGFloat = 8.0
    }
    
    let dotView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = Constants.baseSize / 2
        view.backgroundColor = .AppMainLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .AppMainLight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        addSubview(dotView)
        addSubview(lineView)

        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: Constants.spaceLine),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.leadingAnchor.constraint(equalTo: dotView.trailingAnchor),
            lineView.centerYAnchor.constraint(equalTo: dotView.centerYAnchor),
            
            dotView.widthAnchor.constraint(equalToConstant: Constants.baseSize),
            dotView.heightAnchor.constraint(equalToConstant: Constants.baseSize)
        ])
    }
}

final class GameProgresView: UIView {
    
    let screenWidth = UIScreen.main.bounds.width - 32
    let size: CGFloat = 22.0
    let spaceLine: CGFloat = 8.0
    
    private let notesStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 0
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
    
        notesStack.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for index in 0..<12 {
            let stateView = ProgressDotView()
            stateView.dotView.backgroundColor = .AppMainLight

            if index == 11 {
                stateView.lineView.isHidden = true
            }
            if opensCount < index {
                stateView.dotView.image = Asset.Icons.question.image
                stateView.dotView.tintColor = .AppGray
            } else if opensCount == index {
                stateView.dotView.image = Asset.Icons.progress.image
                stateView.dotView.tintColor = .AppOrange
            } else {
                stateView.dotView.image = Asset.Icons.check.image
                stateView.dotView.tintColor = .white
            }

            stateView.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
            notesStack.addArrangedSubview(stateView)
        }
    }
    
    func configure() {
        Logger.error(msg: screenWidth / 12)
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
