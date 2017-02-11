//
//  GitHubTVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class GitHubTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GitHubAPI.session().start()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if GitHubAPI.session().authToken.isEmpty { login() } else { loadMyGists() }
        
    }
    
    func login() {
    
        present(LoginViewController(session: GitHubAPI.session()), animated: true, completion: nil)
        
    }

    var gists: [Any] = []
    
    func loadMyGists() {
        
        GitHubAPI.session().request(GitHubAPI.Endpoints.gistsMe.endpoint) {
            
            print($0.0 ?? [:])
            // update tableview with list of gists
            
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return gists.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GistCell", for: indexPath)
        
        cell.textLabel?.text = "gist name"
        
        return cell
        
    }

}
