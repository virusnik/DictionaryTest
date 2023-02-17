//
//  Style.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 17.02.2023.
//

import UIKit.UIColor

enum Style {
    enum Image {}
    enum Color {}
    enum Font {}
}

extension Style.Color {
    static let black = #colorLiteral(red: 0,green: 0,blue: 0,alpha: 1)
    static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}
