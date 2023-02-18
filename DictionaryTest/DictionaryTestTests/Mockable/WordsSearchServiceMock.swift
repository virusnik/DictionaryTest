//
//  WordsSearchServiceMock.swift
//  DictionaryTestTests
//
//  Created by Sergio Veliz on 18.02.2023.
//

@testable import DictionaryTest

final class WordsSearchServiceMock: Mockable, WordsSearchServiceable {
    func getWordMeanings(searchText: String) async -> Result<[Word], RequestError> {
        return .success(loadJSON(filename: "words_response", type: [Word].self))
    }
    
    func getWordMeaningsFailere(searchText: String) async -> Result<[Word], RequestError> {
        return .failure(.unknown)
    }
}
