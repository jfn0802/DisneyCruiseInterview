//
//  MarvelAPI_Common.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/19/22.
//

import Foundation
import CryptoKit


let MarvelAPI_PublicKey = "8b4672531b50e507c6490e55beb254e8"
let MarvelAPI_PrivateKey = "fed7587d6eb71653aaeecc09a286ed33299ffd24"
let MarvelAPI_BaseURL = "https://gateway.marvel.com:443/"

func MarvelAPI_AppendBaseParms() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timestamp = format.string(from: Date())
    
    guard let urlTimeStamp = timestamp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return ""
    }
    
    var hash = timestamp + MarvelAPI_PrivateKey + MarvelAPI_PublicKey

    hash = Insecure.MD5.hash(data: hash.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    
    let parms = "?apikey=" + MarvelAPI_PublicKey + "&hash=" + hash + "&ts=" + urlTimeStamp
    
    return parms
}
