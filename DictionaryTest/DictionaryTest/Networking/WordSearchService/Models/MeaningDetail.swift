//
//  Meaning.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 24.02.2023.
//

import Foundation

// MARK: - Meaning
struct MeaningDetail: Codable {
    let id: String
    let wordID, difficultyLevel: Int?
    let partOfSpeechCode, meaningPrefix, text: String?
    let soundURL: String?
    let transcription: String?
    let properties: Properties
    let updatedAt, mnemonics: String?
    let translation: Translation
    let images: [Image]
    let definition: Definition
    let examples: [Definition]
    let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslation]
    let alternativeTranslations: [AlternativeTranslation]

    enum CodingKeys: String, CodingKey {
        case id
        case wordID = "wordId"
        case difficultyLevel, partOfSpeechCode
        case meaningPrefix = "prefix"
        case text
        case soundURL = "soundUrl"
        case transcription, properties, updatedAt, mnemonics, translation, images, definition, examples, meaningsWithSimilarTranslation, alternativeTranslations
    }
}

// MARK: - AlternativeTranslation
struct AlternativeTranslation: Codable {
    let text: String
    let translation: Translation
}

// MARK: - Definition
struct Definition: Codable {
    let text: String
    let soundURL: String

    enum CodingKeys: String, CodingKey {
        case text
        case soundURL = "soundUrl"
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - MeaningsWithSimilarTranslation
struct MeaningsWithSimilarTranslation: Codable {
    let meaningID: Int
    let frequencyPercent, partOfSpeechAbbreviation: String
    let translation: Translation

    enum CodingKeys: String, CodingKey {
        case meaningID = "meaningId"
        case frequencyPercent, partOfSpeechAbbreviation, translation
    }
}

// MARK: - Properties
struct Properties: Codable {
}
