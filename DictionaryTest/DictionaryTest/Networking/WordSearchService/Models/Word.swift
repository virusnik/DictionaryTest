//
//  Word.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 13.02.2023.
//

import Foundation

// MARK: - WordElement
struct Word: Codable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Codable {
    let id: Int
    let partOfSpeechCode: String
    let translation: Translation
    let previewURL, imageURL, transcription: String
    let soundURL: String

    enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

// MARK: - Translation
struct Translation: Codable {
    let text: String
    let note: String?
}


