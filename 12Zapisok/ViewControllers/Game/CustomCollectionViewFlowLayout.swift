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

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var display: CollectionDisplay = .grid(columns: 3)
    private var cellSpacing: CGFloat = 20
    private let righLeftInsets: CGFloat = 20 * 2
    
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.display = display
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
        
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)

        itemSize = CGSize(width: itemWidth(), height: itemHeight())
        print(itemSize)
    }
    
    func itemWidth() -> CGFloat {
        
        let width = collectionView?.frame.width ?? UIScreen.main.bounds.width
        
        switch display {
        case .grid (let columns):
            return (width - (columns - 1) * cellSpacing - righLeftInsets) / columns
            
        case .list:
            return (width - righLeftInsets)
        }
    }
    
    func itemHeight() -> CGFloat {
        switch display {
        case .grid:
            return UIScreen.main.bounds.height * 0.25
            
        case .list:
            return 150
        }
    }
    
}
