//
//  CustomCollectionViewFlowLayout.swift
//  12Zapisok
//
//  Created by A.Makarov on 11/07/2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    case grid(columns: CGFloat)
    case list
}

final class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private enum Constants {
        static let cellSpacing: CGFloat = 20
        static let baseInset: CGFloat = 20.0
        static let bottomInset: CGFloat = 20.0

        static let righLeftInsets: CGFloat = 40 // (20 * 2)
        static let listItemHeight: CGFloat = 150.0
    }
    
    var display: CollectionDisplay = .grid(columns: 3)
    
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.display = display
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = Constants.cellSpacing
        minimumLineSpacing = Constants.cellSpacing
        
        scrollDirection = .vertical
        itemSize = CGSize(width: itemWidth(), height: itemHeight())
        sectionInset = UIEdgeInsets(top: Constants.baseInset,
                                    left: Constants.baseInset,
                                    bottom: Constants.bottomInset,
                                    right: Constants.baseInset)
    }
    
    func itemWidth() -> CGFloat {
        
        let width = collectionView?.frame.width ?? UIScreen.main.bounds.width
        
        switch display {
        case .grid (let columns):
            return (width - (columns - 1) * Constants.cellSpacing - Constants.righLeftInsets) / columns
            
        case .list:
            return (width - Constants.righLeftInsets)
        }
    }
    
    func itemHeight() -> CGFloat {
        switch display {
        case .grid:
            return UIScreen.main.bounds.height * 0.25
            
        case .list:
            return Constants.listItemHeight
        }
    }
    
}
