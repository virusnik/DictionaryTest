//
//  AppNavigationController.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        navigationController.view.backgroundColor = .systemBackground
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let searchListCoordinator = SearchCoordinator(navigationController: navigationController)
        
        childCoordinators.append(searchListCoordinator)
        searchListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
