//
//  MeaningDetaiCoordinator.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 24.02.2023.
//

import UIKit.UINavigationController


class MeaningDetaiCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    
    private let navigationController: UINavigationController
    private var meaningDetailViewModel: MeaningDetailViewModel
    var parentCoordinator: SearchCoordinator?
    
    init(navigationController: UINavigationController,
         meaningDetailViewModel: MeaningDetailViewModel) {
        self.navigationController = navigationController
        self.meaningDetailViewModel = meaningDetailViewModel
    }
    
    func start() {
        let meaningDetailVC = MeaningDetailViewController(viewModel: meaningDetailViewModel)
        navigationController.pushViewController(meaningDetailVC, animated: true)
    }
    
    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
