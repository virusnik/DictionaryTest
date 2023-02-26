//
//  ExString.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 16.02.2023.
//

import Foundation

extension String {
    var withoutPunctuations: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    }
}
