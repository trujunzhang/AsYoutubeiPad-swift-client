//
//  StoryBoardUtils.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class StoryBoardUtils:NSObject {
    
    private class func getMainStoryBoard() -> UIStoryboard {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard
    }
    
    private class func getReusedStoryBoard() -> UIStoryboard {
        let storyboard:UIStoryboard = UIStoryboard(name: "ReusedViewControllers", bundle: nil)
        
        return storyboard
    }
    
    
    class func getChannelBannerViewController() -> ChannelBannerViewController {
        var viewController: ChannelBannerViewController = getReusedStoryBoard().instantiateViewControllerWithIdentifier("ChannelBannerViewController") as ChannelBannerViewController
        
        return viewController
    }
    
    class func getYTTabBarItemsViewController() -> YTTabBarItemsViewController {
        var viewController: YTTabBarItemsViewController = getReusedStoryBoard().instantiateViewControllerWithIdentifier("YTTabBarItemsViewController") as YTTabBarItemsViewController
        
        return viewController
    }
    
    
    class func getYTVideosCollectionViewController() -> YTVideosCollectionViewController {
        var viewController: YTVideosCollectionViewController = getReusedStoryBoard().instantiateViewControllerWithIdentifier("YTVideosCollectionViewController") as YTVideosCollectionViewController
        
        return viewController
    }
    
    
    
}