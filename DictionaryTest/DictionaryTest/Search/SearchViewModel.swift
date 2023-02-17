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
}

class SearchViewModel {
    
    private var service = WordsSearchService()
    @Published private(set) var words: [Word] = []
    @Published private(set) var state: ListViewModelState = .loading
    
    private var bindings = Set<AnyCancellable>()
    
    init(service: WordsSearchService) {
        self.service = service
    }
    
    func getWord(searchText: String) {
        if !searchText.isEmpty && searchText.first != " " && searchText.last != " " && searchText.count > 1 {
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
        let count = words.count
        if count > 0 {
            return count
        }
        return 0
    }
    
    func getRowsCount(section: Int) -> Int {
        let count = words[section].meanings.count
        if count > 0 {
            return count
        }
        return 0
    }
    
}
