//
//  SubscriptionsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import AVFoundation
import Cartography

class SubscriptionsViewController: FrontBaseViewController {

    var menuTableViewController: NBMenuTableViewController?
    // unused(test)
    var menuTableRootView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

//        showChannelPage()

        //        showLeftMenu() // test
        
        showCollectionPanel()//test
    }

    func showLeftMenu() {
        menuTableViewController = NBMenuTableViewController.instance()

        if let viewController: UIViewController = menuTableViewController {
            menuTableRootView = viewController.view

            self.view.addSubview(menuTableRootView!)

            layout(menuTableRootView!) {
                view1 in

                view1.leading == view1.superview!.leading

                view1.top == view1.superview!.top
                view1.bottom == view1.superview!.bottom

                view1.width == LEFT_MENU_WIDTH
            }

            self.addChildViewController(viewController)
        }
    }

    func showChannelPage() {

        let channelPageViewController: ChannelPageViewController = ChannelPageViewController() // used
//        channelPageViewController.channelID = "UCGp4UBwpTNegd_4nCpuBcow" // JetBrainsTV
        channelPageViewController.channelID = "UCl-radPCbXcrYCE4EdNH3QA" // JFK Library
        self.addChildViewController(channelPageViewController)

        let rootView: UIView = channelPageViewController.view
        self.view.addSubview(rootView)
        LayoutUtils.LayoutFullView(rootView)

    }

    func showCollectionPanel() {
//        let channelPageViewController: YTVideosCollectionViewController = YTVideosCollectionViewController.instance()
//        self.addChildViewController(channelPageViewController)
//
//        let rootView: UIView = channelPageViewController.view
//        self.view.addSubview(rootView)
//        LayoutUtils.LayoutFullView(rootView)
    }

    func showWatchVideoPage() {
//        let channelPageViewController: YTVideoWatchViewController = YTVideoWatchViewController()
//        //        channelPageViewController.videoID = "uD6Okha_Yj0"// has subtitle
//        channelPageViewController.videoID = "eoXneK3WIgQ"  // no  subtitle
//        
//        self.addChildViewController(channelPageViewController)
//        
//        let rootView: UIView = channelPageViewController.view
//        self.view.addSubview(rootView)
//        LayoutUtils.LayoutFullView(rootView)
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
