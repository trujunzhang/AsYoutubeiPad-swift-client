//
//  SubscriptionsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import AVFoundation


class SubscriptionsViewController: FrontBaseViewController {
    
    @IBOutlet var container: UIView!
    
    var menuTableViewController: NBMenuTableViewController? // unused(test)
    var menuTableRootView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showChannelPage()
        
        showLeftMenu() // test
    }
    
    func showLeftMenu(){
        menuTableViewController = NBMenuTableViewController()
        
        if let viewController:UIViewController = menuTableViewController {
            menuTableRootView = viewController.view
            
            self.view.addSubview(menuTableRootView!)
            self.addChildViewController(viewController)
        }
    }
    
    func showChannelPage(){
        
        //        let channelPageViewController: ChannelPageViewController = ChannelPageViewController() // used
        
//        let channelPageViewController: YTVideoWatchViewController = YTVideoWatchViewController()
////        channelPageViewController.videoID = "uD6Okha_Yj0"// has subtitle
//        channelPageViewController.videoID = "eoXneK3WIgQ"  // no  subtitle
//        
//        channelPageViewController.view.frame = container.bounds
//        
//        container.addSubview(channelPageViewController.view)
//        
//        self.addChildViewController(channelPageViewController)
    }
    
//    func test(){
//        
//        var tabBarItemsController: UIViewController =
//        self.storyboard!.instantiateViewControllerWithIdentifier("YTTabBarItemsViewController") as! UIViewController
//        
//        
//        let headerView:UIView = UIView()
//        headerView.frame = CGRectMake(0, 100, self.view.frame.size.width, 44)
//        headerView.addSubview(tabBarItemsController.view)
//        
//        
//        //        self.view.addSubview(headerView)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
