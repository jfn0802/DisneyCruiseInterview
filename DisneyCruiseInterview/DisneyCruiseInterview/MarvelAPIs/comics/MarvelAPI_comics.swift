//
//  MarvelAPI_comics.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/18/22.
//

import Foundation
import CryptoKit


func marvelAPI_comics_get(format: MarvelAPI_comics_eNum_format?, characterID: Int?, completion: @escaping (MarvelAPI_comics_codable?) -> ()){
    var buildURL = MarvelAPI_BaseURL + "v1/public/comics" + MarvelAPI_AppendBaseParms()


    if let format = format {
        buildURL = buildURL + "&format=" + format.urlPram
    }
    
    if let characterID = characterID {
        buildURL = buildURL + "&characters=" + String(characterID)
    }
    
    print(buildURL)
    
    let url = URL(string: buildURL)
    
    guard let requestUrl = url else {
        fatalError()
    }
    
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request){ data, response, error in
        let decoder = JSONDecoder()
        
        guard let data = data else {
            return
        }
        do{
            let response = try decoder.decode(MarvelAPI_comics_codable.self, from: data)
            completion(response)
        }
        catch {
            print(error)
        }
    }
    task.resume()
}
