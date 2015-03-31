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
    
    
    class func getChannelBannerViewController() -> ChannelBannerViewController {
        let storyboard:UIStoryboard = getMainStoryBoard()
        var _channelBannerViewController: ChannelBannerViewController = storyboard.instantiateViewControllerWithIdentifier("ChannelBannerViewController") as ChannelBannerViewController
        
        return _channelBannerViewController
    }
    
}