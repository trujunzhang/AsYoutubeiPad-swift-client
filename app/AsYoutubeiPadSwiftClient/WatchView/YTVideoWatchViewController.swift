//
//  YTVideoWatchViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography
class YTVideoWatchViewController: UIViewController {
    
    
    var videoID = ""

    
    var movieEmbeddedViewController:MovieEmbeddedViewController?
    var movieEmbeddedView: UIView?
    var videoWatchInfoViewController:YTVideoWatchInfoViewController?
    var videoWatchSideViewController:YTVideoWatchSideViewController?
    var videoWatchPlaylistHeaderViewController:YTVideoWatchPlaylistHeaderViewController?
    var videoWatchPlaylistViewController:YTVideoWatchPlaylistViewController?
    
    
    
    override func viewDidLoad() {
        
        // 1
        movieEmbeddedViewController                    = StoryBoardUtils.getMovieEmbeddedViewController()
        movieEmbeddedViewController?.videoID = videoID
        
        movieEmbeddedView = movieEmbeddedViewController?.view
        self.view.addSubview(movieEmbeddedView!)
        self.addChildViewController(movieEmbeddedViewController!)
        
        // 2
        videoWatchInfoViewController                   = StoryBoardUtils.getYTVideoWatchInfoViewController()
        videoWatchInfoViewController?.videoID = videoID
        
        // 3
        videoWatchSideViewController                   = StoryBoardUtils.getYTVideoWatchSideViewController()
        videoWatchSideViewController?.videoID = videoID
        
        //4
        videoWatchPlaylistHeaderViewController         = StoryBoardUtils.getYTVideoWatchPlaylistHeaderViewController()
        videoWatchPlaylistHeaderViewController?.videoID = videoID
        
        // 5
        videoWatchPlaylistViewController               = StoryBoardUtils.getYTVideoWatchPlaylistViewController()
        videoWatchPlaylistViewController?.videoID = videoID
        
        
        setupViewLayout()
    }
    
    func setupViewLayout(){
        layout(movieEmbeddedView!) { view1 in
            
            view1.centerX == view1.superview!.centerX
            view1.centerY == view1.superview!.centerY
            
            view1.width   == view1.superview!.width
            view1.height  == view1.superview!.height

        }
    }
    
    
    
    
}
