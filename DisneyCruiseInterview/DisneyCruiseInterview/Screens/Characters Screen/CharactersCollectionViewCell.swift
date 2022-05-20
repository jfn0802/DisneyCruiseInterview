//
//  CharactersCollectionViewCell.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/20/22.
//

import Foundation
import UIKit


class CharactersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var charImage: UIImageView!
    
    func configureCell(char: MarvelAPI_characters_codable_result) {
        self.charImage.image = nil
        
        guard let urlPath = char.thumbnail?.path.replacingOccurrences(of: "http", with: "https"), let fileType = char.thumbnail?.extension else {
            return
        }
                
        let imageUrl = urlPath + "/portrait_uncanny." + fileType
        
        guard let url = URL(string: imageUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.charImage.image = UIImage(data: data)
            }
        }).resume()
    }
}
