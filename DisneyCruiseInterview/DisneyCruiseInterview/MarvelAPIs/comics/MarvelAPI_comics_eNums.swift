//
//  MarvelAPI_comics_eNums.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/19/22.
//

import Foundation

enum MarvelAPI_comics_eNum_format: CaseIterable {
    case comic
    case magazine
    case tradePaperback
    case hardcover
    
    var humanReadable: String {
        switch self {
        case .comic: return "Comic Books"
        case .magazine: return "Magazines"
        case .tradePaperback: return "Trade Paperback"
        case .hardcover: return "Hardcover"
        }
    }
    
    var urlPram: String {
        switch self {
        case .comic: return "comic"
        case .magazine: return "magazine"
        case .tradePaperback: return "trade%20paperback"
        case .hardcover: return "hardcover"
        }
    }
}
