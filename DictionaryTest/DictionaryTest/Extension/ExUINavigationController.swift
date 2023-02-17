//
//  ExUINavigationController.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 16.02.2023.
//

import UIKit.UINavigationController

extension UINavigationController {
    func presentAndCreateNavigation(
        _ viewControllerToPresent: UIViewController,
        style: AppNavigationController.StyleBar? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        var navigationStyle = style
        if let self = self as? AppNavigationController, navigationStyle == nil {
            navigationStyle = self.style
        }
        let presentedNavigationContrller = AppNavigationController(rootViewController: viewControllerToPresent, style: navigationStyle ?? .light)
        self.present(presentedNavigationContrller, animated: animated, completion: completion)
    }
}
