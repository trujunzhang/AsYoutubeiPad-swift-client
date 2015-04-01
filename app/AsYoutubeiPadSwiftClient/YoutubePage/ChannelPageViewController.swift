//
//  ChannelPageViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class ChannelPageViewController:UIViewController {
    
    var channelBannerViewController: ChannelBannerViewController?
    var channelBannerView : UIView?;
    var tabBarView : UIView?
    
    
    override func viewDidLoad() {
        // 1. Top channel Banner panel
        var _channelBannerViewController: ChannelBannerViewController = StoryBoardUtils.getChannelBannerViewController()
        
        channelBannerViewController = _channelBannerViewController
        channelBannerView = _channelBannerViewController.view
        
        self.view.addSubview(channelBannerView!)
        
        // 2.
        var tabBarController:YTTabBarController = YTTabBarController()
        var _tabBarView:UIView = tabBarController.view!
        
        tabBarView = _tabBarView
        
//        tabBarView?.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(tabBarView!)
        
        //3.
        layout(channelBannerView!, tabBarView!) { view1, view2 in
            
            view1.centerX == view1.superview!.centerX
            view2.centerX == view1.centerX
            
            view1.width   == view1.superview!.width
            view2.width   == view1.width
            
            view1.height  == 200
            
            view1.top == view1.superview!.top
            view2.top == view1.bottom
            
            view2.bottom == view2.superview!.bottom
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    
    
}