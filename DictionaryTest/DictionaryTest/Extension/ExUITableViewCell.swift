//
//  ExUITableViewCell.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 16.02.2023.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    static var cellID: String {
        className
    }

    static var nibName: String {
        className
    }
}

extension NSObject {
    var className: String {
        type(of: self).className
    }

    static var className: String {
        String(describing: self)
    }
}
