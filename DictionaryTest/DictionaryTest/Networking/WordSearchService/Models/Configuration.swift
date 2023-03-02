//
//  Configuration.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 02.03.2023.
//

import Foundation

struct Configuration: Decodable {
    var config: String
    var scheme: String
    var host: String
    

    init() {
        config = ""
        scheme = ""
        host = ""
    }
}
