//
//  Extensions+UITableView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 15.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable all

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
