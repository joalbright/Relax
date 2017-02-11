//
//  MarvelTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MarvelTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MarvelAPI.session().start()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MarvelAPI.session().request(MarvelAPI.Endpoints.characters.endpoint) {
                        
            guard let data = $0.0?["data"] as? [String:Any] else { return }
            
            self.characters = data["results"] as? [[String:Any]] ?? []
            self.tableView.reloadData()
            
        }
        
    }
    
    var characters: [ParsedInfo] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return characters.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        
        let character = characters[indexPath.row]
        
        cell.characterNameLabel?.text = character["name"] as? String
        
        DispatchQueue.global().async {
            
            guard let thumbnail = character["thumbnail"] as? ParsedInfo else { return }
            guard let path = thumbnail["path"] as? String else { return }
            guard let ext = thumbnail["extension"] as? String else { return }
            guard let url = URL(string: path + "." + ext) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async(execute: {
                
                cell.characterImageView?.image = image
                
            })
            
        }
        
        return cell
    
    }

}

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func prepareForReuse() {
        
        characterImageView.image = nil
        
    }
    
}
