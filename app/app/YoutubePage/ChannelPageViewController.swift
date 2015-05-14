//
//  ChannelPageViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class ChannelPageViewController: UIViewController {
    
    var channelID: String = "" {
        didSet {
            fetchingChannel()
        }
    }
    
    lazy var channelBannerViewController: ChannelBannerViewController = {
        return ChannelBannerViewController.instance()
        }()
    
    var tabBarViewController: YTTabBarController = YTTabBarController()
    
    override func viewDidLoad() {
        // 1. Top channel Banner panel
        self.view.addSubview(channelBannerViewController.view)
        
        // 2.
        self.addChildViewController(tabBarViewController)
        if let theTabBarView: UIView = tabBarViewController.view {
            theTabBarView.backgroundColor = UIColor.clearColor()
            self.view.addSubview(theTabBarView)
        }
        
        //3.
        channelBannerViewController.view.LayoutRelatedView(tabBarViewController.view,height:200)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    // MARK: fetch channel by channelId
    func fetchingChannel() {
        
        YoutubeFetcher.fetchChannelForPageChannel(channelID, completeHandler: {
            (object, sucess) -> Void in
            
            if (sucess == true) {
                self.fetchedChannel(object as! MABYT3_Channel)
            }
        })
        
    }
    
    func fetchedChannel(channel: MABYT3_Channel) {
        channelBannerViewController.updatePanel(channel)
    }
    
    
}