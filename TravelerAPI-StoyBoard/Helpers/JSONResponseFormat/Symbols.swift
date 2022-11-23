//
//  Symbols.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-16.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

// MARK: - Info
struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}
