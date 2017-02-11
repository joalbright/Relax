//
//  InstagramCVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class InstagramCVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        InstagramAPI.session().start()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if InstagramAPI.session().authToken.isEmpty { login() } else { loadMedia() }
        
    }
    
    func login() {
        
        present(LoginViewController(session: InstagramAPI.session()), animated: true, completion: nil)

    }
    
    var photos: [ParsedInfo] = []
    
    func loadMedia() {
        
        var media = InstagramAPI.Endpoints.usersMyMedia.endpoint
        
        // 1117765869475060984_6261910
        //  970209583255379454_6261910
        
        media.parameters = ["count" : "50"]
        
        InstagramAPI.session().request(media) {
         
            print($0.0 ?? [:])
            
            guard let items = $0.0?["data"] as? [[String:Any]] else { return }
            
            
            
            self.photos = items.filter { $0["type"] as? String == "image" }
            self.collectionView?.reloadData()
            
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return photos.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    
        let photo = photos[indexPath.item]
        
        DispatchQueue.global().async {
            
            guard let images = photo["images"] as? ParsedInfo else { return }
            guard let resolution = images["standard_resolution"] as? ParsedInfo else { return }
            guard let urlString = resolution["url"] as? String else { return }
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                
                cell.imageView.image = image
                
            }
            
        }
    
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let wh = (collectionView.frame.width - 10) / 3
        return CGSize(width: wh, height: wh)
            
    }
    
    

}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}
