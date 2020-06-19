//
//  UITableView+Ext.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCells<T> (cells : [T.Type]) where T: UITableViewCell  {
        for cell in cells  {
            let nib = UINib(nibName: String(describing: cell), bundle: nil)
            register(nib, forCellReuseIdentifier: String(describing: cell))
        }
    }
}

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}


extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
