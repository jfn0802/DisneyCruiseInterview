//
//  CharactersViewController.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/20/22.
//

import Foundation
import UIKit


class CharactersViewController: UIViewController {
    
    var characters: [MarvelAPI_characters_codable_result] = []
    var selectedChar: passCharToMainScreenProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCharacterData()
    }
    
    
    func reloadCharacterData(){
        self.characters.removeAll()
        self.collectionView.reloadData()
        
        marvelAPI_characters_get() { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.characters = response.data.results
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCollectionViewCell", for: indexPath) as! CharactersCollectionViewCell
        
        cell.configureCell(char: characters[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let char = characters[indexPath.row].id
        selectedChar?.getSelectedChar(charID: char)
        self.dismiss(animated: true)
    }
    
}

protocol passCharToMainScreenProtocol {
    func getSelectedChar(charID: Int)
}
