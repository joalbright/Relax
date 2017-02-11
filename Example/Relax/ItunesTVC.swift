//
//  ItunesTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ItunesTVC: UITableViewController {
    
    var items: [ParsedInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItunesAPI.session().start()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        search("daft+punk", entity: "album")
        
    }
    
    func search(_ term: String, entity: String) {
        
        var search = ItunesAPI.Endpoints.Search.endpoint
        
        search.parameters = ["term" : term, "entity": entity]
        
        ItunesAPI.session().request(search) {
            
            guard let info = $0.0 else { return }
            
            self.items = info["results"] as? [[String:Any]] ?? []
            self.tableView.reloadData()
            
        }

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return items.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item["collectionName"] as? String
        cell.detailTextLabel?.text = item["artistName"] as? String
        
        return cell
        
    }

}
