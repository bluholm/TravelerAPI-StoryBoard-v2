//
//  Translate.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import Foundation

// MARK: - Translate
struct Translate: Codable {
    
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    
    let detectedSourceLanguage, text: String

    enum CodingKeys: String, CodingKey {
        
        case detectedSourceLanguage = "detected_source_language"
        case text
    }
}
