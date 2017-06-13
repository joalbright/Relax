//
//  FoursquareVC.swift
//  Relax
//
//  Created by Jo Albright on 1/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MapKit

class FoursquareVC: UIViewController {

    @IBOutlet weak var venuesMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FoursquareAPI.session().start()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if FoursquareAPI.session().authToken.isEmpty { login() } else { loadVenues() }
        
    }

    func login() {
        
        present(LoginViewController(session: FoursquareAPI.session()), animated: true, completion: nil)
        
    }
    
    func loadVenues() {
        
        var explore = FoursquareAPI.Endpoints.venuesExplore.endpoint
        
        explore.parameters = ["near" : "atlanta"]
        
        FoursquareAPI.session().request(explore) { info, error in
                        
            guard let response = info?["response"] as? [String:Any] else { return }
            guard let groups = response["groups"] as? [[String:Any]] else { return }
            
            for group in groups {
                
                guard let items = group["items"] as? [[String:Any]] else { continue }
                
                for item in items {
                    
                    guard let venue = item["venue"] as? [String:Any] else { continue }
                    guard let location = venue["location"] as? [String:Any] else { continue }
                    guard let lat = location["lat"] as? Double else { continue }
                    guard let lng = location["lng"] as? Double else { continue }
                    
                    let annotation = MKPointAnnotation()
                    
                    annotation.title = venue["name"] as? String
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    
                    self.venuesMapView.addAnnotation(annotation)
                    
                }
                
            }
            
            // update map with markers
            
            self.venuesMapView.showAnnotations(self.venuesMapView.annotations, animated: true)
            
        }
        
    }

}
