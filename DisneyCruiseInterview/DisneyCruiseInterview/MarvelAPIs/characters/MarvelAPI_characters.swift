//
//  MarvelAPI_characters.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/20/22.
//

import Foundation

func marvelAPI_characters_get(completion: @escaping (MarvelAPI_characters_codable?) -> ()){
    let buildURL = MarvelAPI_BaseURL + "v1/public/characters" + MarvelAPI_AppendBaseParms()
    
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
            let response = try decoder.decode(MarvelAPI_characters_codable.self, from: data)
            completion(response)
        }
        catch {
            print(error)
        }
    }
    task.resume()
}
