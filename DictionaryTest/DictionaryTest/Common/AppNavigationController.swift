//
//  AppNavigationController.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import UIKit

final class AppNavigationController: UINavigationController {
    enum StyleBar {
        case light
        case dark
    }

    var style: StyleBar = .light
    private var rootViewController: UIViewController?

    private func configurate() {
        self.navigationBar.isTranslucent = true
        switch style {
        case .light: self.navigationBar.barTintColor = .white
        case .dark: self.navigationBar.barTintColor = .black
        }
        self.modalPresentationStyle = .currentContext
        self.navigationBar.barStyle = .default
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        self.rootViewController = rootViewController
        self.configurate()
    }

    convenience init(rootViewController: UIViewController, style: StyleBar) {
        self.init(rootViewController: rootViewController)
        self.rootViewController = rootViewController
        self.style = style
        self.configurate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch style {
        case .light:
            return .lightContent
        case .dark:
            return .darkContent
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


