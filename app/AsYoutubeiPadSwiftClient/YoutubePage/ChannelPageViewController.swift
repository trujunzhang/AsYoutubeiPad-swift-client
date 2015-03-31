//
//  ChannelPageViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class ChannelPageViewController:UIViewController {
    
    var channelBannerViewController: ChannelBannerViewController?
    var channelBannerView : UIView?;
    var tabBarPannel : YTTabBarController?
    

    
    override func viewDidLoad() {
        // 1. Top channel Banner panel
        var _channelBannerViewController: ChannelBannerViewController = StoryBoardUtils.getChannelBannerViewController()
        
        channelBannerViewController = _channelBannerViewController
        channelBannerView = _channelBannerViewController.view
        channelBannerView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        
//        self.view.addSubview(channelBannerView!)
        
        // 2.
        var tabBarController:YTTabBarController = YTTabBarController()
        var tabBarView:UIView = tabBarController.view!
        tabBarView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200)
        
        self.view.addSubview(tabBarView)
        
    }
    
    func makeTabBarViewPanel(){
        
    }
    
    
}