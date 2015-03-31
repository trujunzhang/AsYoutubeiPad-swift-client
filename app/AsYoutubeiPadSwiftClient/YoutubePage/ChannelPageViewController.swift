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
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var _channelBannerViewController: ChannelBannerViewController = storyboard.instantiateViewControllerWithIdentifier("ChannelBannerViewController") as ChannelBannerViewController
        
        channelBannerViewController = _channelBannerViewController
        channelBannerView = _channelBannerViewController.view
        channelBannerView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 300)
        
        self.view.addSubview(channelBannerView!)
    }
    
    func makeTabBarViewPanel(){
        
    }
    
    
}