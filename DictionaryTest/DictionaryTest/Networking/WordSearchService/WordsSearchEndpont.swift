//
//  WordsSearchEndpont.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation

enum WordsSearchEndpont {
    case wordsSearch(searchText: String)
    case meanings(id: String)
}

extension WordsSearchEndpont: Endpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .wordsSearch(let text):
            return [URLQueryItem(name: "search", value: text)]
        case .meanings(id: let id):
            return [URLQueryItem(name: "ids", value: id)]
        }
    }
    
    var path: String {
        switch self {
        case .wordsSearch:
            return "/api/public/v1/words/search"
        case .meanings:
            return "/api/public/v1/meanings"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .wordsSearch, .meanings:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .wordsSearch, .meanings:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .wordsSearch, .meanings:
            return nil
        }
    }
}
