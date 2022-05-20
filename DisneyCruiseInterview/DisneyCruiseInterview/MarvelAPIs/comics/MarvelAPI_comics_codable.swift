//
//  MarvelAPI_comics_codable.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/19/22.
//

import Foundation

struct MarvelAPI_comics_codable: Codable {
    let code: Int
    let data: MarvelAPI_comics_codable_data
}

struct MarvelAPI_comics_codable_data: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelAPI_comics_codable_result]
}

struct MarvelAPI_comics_codable_result: Codable {
    let id: Int
    let title: String
    let issueNumber: Int
    let description: String?
    let thumbnail: MarvelAPI_comics_codable_thumbnail?
}

struct MarvelAPI_comics_codable_thumbnail: Codable {
    let path: String
    let `extension`: String
}
