//
//  ComicsTableViewCell.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/19/22.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    
    func configureCell(comic: MarvelAPI_comics_codable_result) {
        
        comicTitle.text = comic.title
        self.comicImage.image = nil
        
        guard let urlPath = comic.thumbnail?.path.replacingOccurrences(of: "http", with: "https"), let fileType = comic.thumbnail?.extension else {
            return
        }
                
        let imageUrl = urlPath + "/landscape_incredible." + fileType
        
        guard let url = URL(string: imageUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.comicImage.image = UIImage(data: data)
            }
        }).resume()
    }
}
