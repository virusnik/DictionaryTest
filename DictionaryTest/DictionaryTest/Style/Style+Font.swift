//
//  Style+Font.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 01.03.2023.
//

import UIKit.UIFont

extension Style.Font {
    enum FontName: String {
        case bold
        case light
        case medium
        case regular
        case semiBold
    }

// MARK: - Style for Meaning Detail 
    static let wordValue = makeFont(.medium, 22)
    static let translationValue = makeFont(.regular, 18)
    static let transcriptionValue = makeFont(.regular, 18)

    
    //MARK: - Style for custom alert
    static let customAlertTitle = makeFont(.bold, 20)
    static let customAlertMessage = makeFont(.regular, 14)
    static let customAlertButton = makeFont(.bold, 14)

    // MARK: - Private

    private static func bold(size: CGFloat) -> UIFont {
        makeFont(.bold, size)
    }

    private static func light(size: CGFloat) -> UIFont {
        makeFont(.light, size)
    }

    private static func medium(size: CGFloat) -> UIFont {
        makeFont(.medium, size)
    }

    private static func regular(size: CGFloat) -> UIFont {
        makeFont(.regular, size)
    }

    private static func semiBold(size: CGFloat) -> UIFont {
        makeFont(.semiBold, size)
    }

    private static func customizeNumbers(in font: UIFont, size: CGFloat) -> UIFont {
        let numberUppercaseAttributes = [
            UIFontDescriptor.FeatureKey.selector: kNumberCaseType,
            UIFontDescriptor.FeatureKey.type: kUpperCaseNumbersSelector
        ]
        let newDescriptor = font.fontDescriptor.addingAttributes([
            .featureSettings: numberUppercaseAttributes
        ])
        return UIFont(descriptor: newDescriptor, size: size)
    }

    private static func makeFont(_ name: FontName, _ size: CGFloat) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size) {
            return customizeNumbers(in: font, size: size)
        } else {
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
}
