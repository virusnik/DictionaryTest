//
//  SearchViewModel.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation
import Combine

enum ListViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(RequestError)
    
    static func == (lhs: ListViewModelState, rhs: ListViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.finishedLoading, .finishedLoading): return true
        case (.loading, .loading): return true
        case (.error, .error): return true
        default: return false
        }
    }
}

class SearchViewModel {
    
    private var service: WordsSearchServiceable
    @Published private(set) var words: [Word] = []
    @Published private(set) var state: ListViewModelState = .finishedLoading
    var coordinator: SearchCoordinator?
    
    private var bindings = Set<AnyCancellable>()
    
    init(service: WordsSearchServiceable) {
        self.service = service
    }
    
    func getWord(searchText: String) {
        if !searchText.isEmpty && searchText.first != " " && searchText.last != " " && searchText.count > 1 {
            self.state = .loading
            Task(priority: .userInitiated) {
                let result = await service.getWordMeanings(searchText: searchText)
                switch result {
                case .success(let meaningsResponse):
                    words = meaningsResponse
                    self.state = .finishedLoading
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }
    
    func getSectionsCount() -> Int {
        return words.count
    }
    
    func getRowsCount(section: Int) -> Int {
        return words[section].meanings.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let meaning = words[indexPath.section].meanings[indexPath.row]
        if let coordinator = coordinator {
            coordinator.onSelect(String(meaning.id))
        }
    }
    
}
