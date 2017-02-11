//
//  WebViewController.swift
//  InPassing
//
//  Created by Jo Albright on 7/21/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

extension UIViewController { }

class LoginViewController: UIViewController, UIWebViewDelegate, Loginable {

    var loginWebView = UIWebView()
    
    var session: API!
    
    convenience init(session: API) { self.init(); self.session = session }
    
    override func viewWillAppear(_ animated: Bool) {
                
        guard let urlString = try? session.url(loginDetails.auth) else { return }
        guard let url = URL(string: urlString) else { return }
        
        view.addSubview(loginWebView)
        loginWebView.delegate = self
        loginWebView.frame = view.frame
        
        loginWebView.loadRequest(URLRequest(url: url))
        
    }
    
    var loaded = false
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let loadedURL = request.url?.absoluteString else { return true }
                
        if loadedURL.contains("client_id") { return true }
        
        requestToken(loadedURL, endpoint: loginDetails.authCode, api: session) { [weak self] (success) -> Void in
            
            self?.dismiss(animated: true, completion: nil)
            
        }
        
        return true
        
    }

}

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.navigationController?.navigationBar.barTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1.0)
            
        }) 
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIButton else { return }
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.navigationController?.navigationBar.barTintColor = button.backgroundColor

            
        }) 
        
        
    }
    
}

@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
    }
    
}
