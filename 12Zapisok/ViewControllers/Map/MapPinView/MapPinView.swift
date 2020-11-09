//
//  MapPinView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.11.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import UIKit

final class MapPinView: UIView, NibInstance {
    
    private enum Constants {
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 2.0
        static let shadowColor = UIColor.gray.cgColor
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 3.0
        static let shadowOffset = CGSize(width: 0, height: 0.7)
    }
    
    @IBOutlet private weak var pinView: UIView!
    @IBOutlet private weak var pinImage: UIImageView!
    @IBOutlet private weak var noteLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
        congifUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
        congifUI()
    }
    
    private func congifUI() {
        pinImage.layer.borderColor = UIColor.appColor.cgColor
        pinImage.layer.borderWidth = Constants.borderWidth
        pinImage.backgroundColor = .white
        pinImage.contentMode = .scaleAspectFill
        
        pinImage.rounded()
        
        pinView.layer.masksToBounds = true
        pinView.layer.cornerRadius = Constants.cornerRadius
    
        layer.shadowColor = Constants.shadowColor
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowRadius = Constants.shadowRadius
    
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.selectMarket))
        addGestureRecognizer(gesture)
    }
    
    public func configure(_ marker: UIImage? = nil, noteId: Int) {
        frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        setNeedsLayout()
        layoutIfNeeded()

        pinImage.image = marker
        noteLabel.text = "Записка #\(noteId)"
    }
    
    @objc
    private func selectMarket(sender: UITapGestureRecognizer) {
        Logger.info(msg: "Tap Pin")
    }
}
