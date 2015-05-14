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
        if let theChannelBannerView: UIView = channelBannerViewController.view, theTabBarView: UIView = tabBarViewController.view {
            layout(theChannelBannerView, theTabBarView) {
                view1, view2 in
                
                view1.centerX == view1.superview!.centerX
                view2.centerX == view1.centerX
                
                view1.width == view1.superview!.width
                view2.width == view1.width
                
                view1.height == 200
                
                view1.top == view1.superview!.top
                view2.top == view1.bottom
                
                view2.bottom == view2.superview!.bottom
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        var x = 0
    }
    
    // MARK: fetch channel by channelId
    func fetchingChannel() {
        
        YoutubeFetcher.fetchChannelForPageChannel(channelID, completeHandler: {
            (object, sucess) -> Void in
            
            if (sucess == true) {
                var channel: MABYT3_Channel = object as! MABYT3_Channel
                self.fetchedChannel(channel)
            }
        })
        
    }
    
    func fetchedChannel(channel: MABYT3_Channel) {
        channelBannerViewController.updatePanel(channel)
    }
    
    
}