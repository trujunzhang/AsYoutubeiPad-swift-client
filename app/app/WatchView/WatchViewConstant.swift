//
//  WatchViewStoryboardUtils.swift
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation

let STORYBOARD_VIDEOWATCH_NAME = "VideoWatchStoryboard"



extension YTVideoWatchViewController {
    
    class func instance() -> YTVideoWatchViewController {
        
        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("YTVideoWatchViewController") as! YTVideoWatchViewController
    }
}

extension MovieEmbeddedViewController {

    class func instance() -> MovieEmbeddedViewController {

        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("MovieEmbeddedViewController") as! MovieEmbeddedViewController
    }
}


extension YTVideoWatchPlaylistHeaderViewController {

    class func instance() -> YTVideoWatchPlaylistHeaderViewController {

        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("YTVideoWatchPlaylistHeaderViewController") as! YTVideoWatchPlaylistHeaderViewController
    }
}


extension MovieEmbeddedNormalBarViewController {

    class func instance() -> MovieEmbeddedNormalBarViewController {

        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("MovieEmbeddedNormalBarViewController") as! MovieEmbeddedNormalBarViewController
    }
}

extension VideoInfoViewController {

    class func instance() -> VideoInfoViewController {

        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("VideoInfoViewController") as! VideoInfoViewController
    }
}


