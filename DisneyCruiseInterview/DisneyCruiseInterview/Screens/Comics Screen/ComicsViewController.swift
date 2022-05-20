//
//  ViewController.swift
//  DisneyCruiseInterview
//
//  Created by Jonathan Nammour on 5/18/22.
//

import UIKit

class ComicsViewController: UIViewController {
    var comics: [MarvelAPI_comics_codable_result] = []
    var comics_filter: MarvelAPI_comics_eNum_format?
    var comics_selectedCharID: Int?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var formatButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let MarvelLogo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:MarvelLogo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        reloadComicData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let charScreen = segue.destination as? CharactersViewController {
            charScreen.selectedChar = self
        }
    }
    
    func reloadComicData(){
        self.comics.removeAll()
        self.tableView.reloadData()
        
        marvelAPI_comics_get(format: comics_filter, characterID: comics_selectedCharID) { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.comics = response.data.results
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    @IBAction func formatButtonSelected(_ sender: Any) {
        let alert = UIAlertController(title: "Search by Format", message: nil, preferredStyle: .actionSheet)
        
        for format in MarvelAPI_comics_eNum_format.allCases {
            alert.addAction(UIAlertAction(title: format.humanReadable, style: .default , handler:{ (UIAlertAction)in
                self.comics_filter = format
                self.reloadComicData()
            }))
        }

        alert.addAction(UIAlertAction(title: "Any Format ", style: .default , handler:{ (UIAlertAction)in
            self.comics_filter = nil
            self.reloadComicData()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            // Do nothing 😊
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func characterButtonSelected(_ sender: Any) {
        let alert = UIAlertController(title: "Search by Character", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Select Character", style: .default , handler:{ (UIAlertAction) in
            self.performSegue(withIdentifier: "selectChar", sender: nil)
        }))
        
        if comics_selectedCharID != nil {
            alert.addAction(UIAlertAction(title: "Clear Character", style: .default , handler:{ (UIAlertAction) in
                self.comics_selectedCharID = nil
                self.reloadComicData()
            }))
        }

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            // Do nothing 😊
        }))

        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
extension ComicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as! ComicsTableViewCell
        
        cell.configureCell(comic: comics[indexPath.row])
        
        return cell
    }
    
}

extension ComicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ComicsViewController: passCharToMainScreenProtocol{
    func getSelectedChar(charID: Int) {
        comics_selectedCharID = charID
        reloadComicData()
    }
}

