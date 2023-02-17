//
//  Endpoint.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "dictionary.skyeng.ru"
    }
}

enum RequestMethod: String {
    case delete
    case get
    case patch
    case post
    case put
}


enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .invalidURL:
            return "invalid URL"
        default:
            return "Unknown error"
        }
    }
}
