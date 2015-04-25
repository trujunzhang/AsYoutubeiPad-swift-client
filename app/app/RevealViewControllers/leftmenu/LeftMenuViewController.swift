//
//  LeftMenuViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Cartography

class LeftMenuViewController: UIViewController ,SWRevealViewControllerDelegate{
    
    var menuTableViewController: NBMenuTableViewController?
    var menuTableRootView: UIView?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initMenuTableView()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initMenuTableView() {
        menuTableViewController = NBMenuTableViewController.instance()
        
        if let viewController:UIViewController = menuTableViewController {
            menuTableRootView = viewController.view
            
            self.view.addSubview(menuTableRootView!)
            self.addChildViewController(viewController)
        }
    }
    
    
    
    
}
