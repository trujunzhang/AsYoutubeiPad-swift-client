//
//  FrontBaseViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class FrontBaseViewController: UIViewController {

    lazy var revealIconButton: UIBarButtonItem = {
        var btn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            self.navigationItem.leftBarButtonItem = revealIconButton
//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // used
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}