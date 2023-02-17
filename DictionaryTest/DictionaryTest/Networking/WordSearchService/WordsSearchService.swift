//
//  WordsSearchService.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation


protocol WordsSearchServiceable {
    func getWordMeanings(searchText: String) async -> Result<[Word], RequestError>
}

struct WordsSearchService: HTTPClient, WordsSearchServiceable {
    func getWordMeanings(searchText: String) async -> Result<[Word], RequestError> {
        return await sendRequest(endpoint: WordsSearchEndpont.wordsSearch(searchText: searchText),
                                 responseModel: [Word].self)
    }
}
