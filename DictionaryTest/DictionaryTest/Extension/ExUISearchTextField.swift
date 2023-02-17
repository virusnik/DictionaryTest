//
//  ExUISearchTextField.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 16.02.2023.
//

import UIKit.UISearchTextField
import Combine

extension UISearchTextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UISearchTextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
}
