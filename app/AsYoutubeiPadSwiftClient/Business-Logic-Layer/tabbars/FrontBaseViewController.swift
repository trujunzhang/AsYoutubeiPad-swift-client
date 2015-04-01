//
//  FrontBaseViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class FrontBaseViewController:UIViewController {
    
    var leftMenuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            leftMenuButton = UIBarButtonItem(image: UIImage(named: "reveal-icon"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
            self.navigationController?.navigationItem.leftBarButtonItems = [leftMenuButton]
            
            //            leftMenuButton.target = self.revealViewController()
            //            leftMenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
}