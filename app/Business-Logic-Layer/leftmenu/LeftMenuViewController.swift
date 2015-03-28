//
//  LeftMenuViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController ,SWRevealViewControllerDelegate{

    
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
        
//        var menuViewController:AsMenuTableViewController = AsMenuTableViewController(viewWidth: REAR_VIEW_WIDTH)
//        self.addChildViewController(menuViewController)
//        
//        var addView =  menuViewController.view;
//        self.view.addSubview(addView)
//        
//        menuViewController.didMoveToParentViewController(self)
//        addView.frame=self.view.bounds;
    }
    

    
    
}
