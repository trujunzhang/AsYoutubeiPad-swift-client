//
//  LeftMenuViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Cartography

class LeftMenuViewController: UIViewController, SWRevealViewControllerDelegate {

    var menuTableViewController: NBMenuTableViewController?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            let x = 0
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        initMenuTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initMenuTableView() {
        menuTableViewController = NBMenuTableViewController.instance()

        if let viewController: UIViewController = menuTableViewController {
            let menuTableRootView: UIView = viewController.view

            self.view.addSubview(menuTableRootView)
            self.addChildViewController(viewController)
        }
    }


}
