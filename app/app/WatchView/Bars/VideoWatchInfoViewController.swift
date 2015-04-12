//
//  VideoWatchInfoViewController.swift
//  app
//
//  Created by djzhang on 4/12/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class VideoWatchInfoViewController: UIViewController {
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        if let ai : UIActivityIndicatorView = loadingIndicator{
            
            ai.frame = CGRectMake(0, 0, 50, 50)
            ai.center = self.view.center
            ai.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge;
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startIndicator()
    }
    
    func startIndicator(){
        if let ai : UIActivityIndicatorView = loadingIndicator{
            ai.startAnimating()
        }
    }
    
    func stopIndicator(){
        if let ai : UIActivityIndicatorView = loadingIndicator{
            ai.stopAnimating()
        }
    }
    
    
    
}