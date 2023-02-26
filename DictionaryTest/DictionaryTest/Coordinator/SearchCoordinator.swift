//
//  SearchCoordinator.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 24.02.2023.
//

import UIKit.UINavigationController

final class SearchCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewModel = SearchViewModel(service: WordsSearchService())
        searchViewModel.coordinator = self
        
        let searchVC = SearchViewController(viewModel: searchViewModel)
        
        navigationController.setViewControllers([searchVC], animated: false)
    }
    
    func onSelect(_ id: String) {
        let meaningDetailViewModel = MeaningDetailViewModel(service: WordsSearchService())
        meaningDetailViewModel.getWord(id: id)
        
        let meaningDetailCoordinator = MeaningDetaiCoordinator(navigationController: navigationController, meaningDetailViewModel: meaningDetailViewModel)
        
        meaningDetailCoordinator.parentCoordinator = self
        childCoordinators.append(meaningDetailCoordinator)
        meaningDetailCoordinator.start()
    }
    
}
