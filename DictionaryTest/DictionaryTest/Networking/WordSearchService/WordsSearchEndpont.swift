//
//  WordsSearchEndpont.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation

enum WordsSearchEndpont {
    case wordsSearch(searchText: String)
}

extension WordsSearchEndpont: Endpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .wordsSearch(let text):
            return [URLQueryItem(name: "search", value: text)]
        }
    }
    
    var path: String {
        switch self {
        case .wordsSearch:
            return "/api/public/v1/words/search"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .wordsSearch:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .wordsSearch:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .wordsSearch:
            return nil
        }
    }
}
