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
    // JFK Library
    let channelID = "UCl-radPCbXcrYCE4EdNH3QA"
    // JetBrainsTV
    //    let channelID = "UCGp4UBwpTNegd_4nCpuBcow"
    
    // MARK: searchBar
    lazy var searchBar: AutoCompletePopoverSearchBar = {
        let _searchBar: AutoCompletePopoverSearchBar = AutoCompletePopoverSearchBar(frame: CGRectMake(0, 0, 200, 20))
        _searchBar.placeholder = "Searching..."
        
        _searchBar.backgroundColor = UIColor.clearColor()
        _searchBar.showsCancelButton = true
        _searchBar.userInteractionEnabled = true
        
        _searchBar.popoverEvent = AutoCompletePopoverEvent()
        return _searchBar
        }()
    
    
    // MARK:
    var lastViewController: UIViewController?
    
    var menuTableViewController: NBMenuTableViewController?
    // unused(test)
    var menuTableRootView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchItem: UIBarButtonItem = UIBarButtonItem(customView: searchBar)
        //        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = searchItem
        self.searchBar.rightBarItem = self.navigationItem.rightBarButtonItem
        
        // Register
        if self.revealViewController() != nil {
            RevealViewHelper.sharedInstance.registerSubscriptionsViewController(self)
        }
        
        self.edgesForExtendedLayout = .None
        
        //        showChannelPage(channelID)
        
        //        showCollectionPanel()//test
        
        showWatchVideoPage()
        
        //        showSearchPanel("Sketch 3")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("onKeyboardHide"), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func onKeyboardHide() {
        self.searchBar.onKeyboardHide()
    }
    
    
    func cleanLastController() {
        if let theViewController: UIViewController = self.lastViewController {
            theViewController.removeFromParentViewController()
            let rootView: UIView = theViewController.view
            rootView.removeFromSuperview()
        }
    }
    
    func showChannelPage(channelID: NSString) {
        // 1. Clean last panel
        self.cleanLastController()
        
        // 2. Add new panel to root view
        let viewController: ChannelPageViewController = ChannelPageViewController() // used
        viewController.channelID = channelID as String
        self.addChildViewController(viewController)
        
        self.view.addSubview(viewController.view)
        LayoutUtils.LayoutFullView(viewController.view)
    }
    
    func showSearchPanel(searchWish: String) {
        // 1. Clean last panel
        self.cleanLastController()
        
        // 2. Add new panel to root view
        let viewController: YTVideosCollectionViewController = YTVideosCollectionViewController.instance()
        viewController.setCollectionTask(searchWish,delegate: SearchEvent())
        
        self.addChildViewController(viewController)
        
        self.view.addSubview(viewController.view)
        LayoutUtils.LayoutFullView(viewController.view)
    }
    
    func showCollectionPanel() {
        if (YoutubeUserProfile.sharedInstance.hasLogin() == false) {
            return
        }
        //        let channelPageViewController: NBVideosCollectionViewController = NBVideosCollectionViewController.instance()
        
        let viewController: YTVideosCollectionViewController = YTVideosCollectionViewController.instance()
        let event: RetrievingNewestVideoIdsEvent = RetrievingNewestVideoIdsEvent()
        viewController.setCollectionTask("",delegate: SearchEvent())
        
        self.addChildViewController(viewController)
        
        self.view.addSubview(viewController.view)
        LayoutUtils.LayoutFullView(viewController.view)
    }
    
    func showWatchVideoPage() {
        let viewController: YTVideoWatchViewController = YTVideoWatchViewController()
        viewController.videoID = "uD6Okha_Yj0"// has subtitle
        //        viewController.videoID = "eoXneK3WIgQ"  // no  subtitle
        
        self.addChildViewController(viewController)
        
        self.view.addSubview(viewController.view)
        LayoutUtils.LayoutFullView(viewController.view)
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
