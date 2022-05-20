//
//  MarvelAPI_characters_codable.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/20/22.
//

import Foundation

struct MarvelAPI_characters_codable: Codable {
    let code: Int
    let data: MarvelAPI_characters_codable_data
}

struct MarvelAPI_characters_codable_data: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelAPI_characters_codable_result]
}

struct MarvelAPI_characters_codable_result: Codable {
    let id: Int
    let name: String
    let thumbnail: MarvelAPI_characters_codable_thumbnail?
}

struct MarvelAPI_characters_codable_thumbnail: Codable {
    let path: String
    let `extension`: String
}
