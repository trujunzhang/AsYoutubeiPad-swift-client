//
//  WatchViewStoryboardUtils.swift
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class WatchViewStoryboardUtils {
    
    private class func getVideoWatchStoryboard() -> UIStoryboard {
        let storyboard:UIStoryboard = UIStoryboard(name: "VideoWatchStoryboard", bundle: nil)
        
        return storyboard
    }
    
    
    // MARK : WatchView
    class func getMovieEmbeddedViewController() -> MovieEmbeddedViewController {
        var viewController: MovieEmbeddedViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("MovieEmbeddedViewController") as! MovieEmbeddedViewController
        
        return viewController
    }
    
    class func getYTVideoWatchInfoViewController() -> YTVideoWatchInfoViewController {
        var viewController: YTVideoWatchInfoViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("YTVideoWatchInfoViewController") as! YTVideoWatchInfoViewController
        
        return viewController
    }
    
    class func getYTVideoWatchSideViewController() -> YTVideoWatchSideViewController {
        var viewController: YTVideoWatchSideViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("YTVideoWatchSideViewController") as! YTVideoWatchSideViewController
        
        return viewController
    }
    
    class func getYTVideoWatchPlaylistHeaderViewController() -> YTVideoWatchPlaylistHeaderViewController {
        var viewController: YTVideoWatchPlaylistHeaderViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("YTVideoWatchPlaylistHeaderViewController") as! YTVideoWatchPlaylistHeaderViewController
        
        return viewController
    }
    
    class func getYTVideoWatchPlaylistViewController() -> YTVideoWatchPlaylistViewController {
        var viewController: YTVideoWatchPlaylistViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("YTVideoWatchPlaylistViewController") as! YTVideoWatchPlaylistViewController
        
        return viewController
    }
    
    // MARK: MovieEmbedded Bars
    class func getMovieEmbeddedNormalBarViewController() -> MovieEmbeddedNormalBarViewController {
        var viewController: MovieEmbeddedNormalBarViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("MovieEmbeddedNormalBarViewController") as! MovieEmbeddedNormalBarViewController
        
        return viewController
    }
    
    
    
    class func getVideoInfoViewController() -> VideoInfoViewController {
        var viewController: VideoInfoViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("VideoInfoViewController") as! VideoInfoViewController
        
        return viewController
    }
    
    
    //    class func getMovieEmbeddedFullscreenBarViewController() -> MovieEmbeddedFullscreenBarViewController {
    //        var viewController: MovieEmbeddedFullscreenBarViewController = getVideoWatchStoryboard().instantiateViewControllerWithIdentifier("MovieEmbeddedFullscreenBarViewController") as! MovieEmbeddedFullscreenBarViewController
    //
    //        return viewController
    //    }
    
    
    

    
}