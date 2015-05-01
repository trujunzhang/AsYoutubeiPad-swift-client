//
//  FrontBaseViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class FrontBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {

//            let leftMenuButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
            let leftMenuButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Travel"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
            self.navigationItem.leftBarButtonItem = leftMenuButton

//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // used
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}