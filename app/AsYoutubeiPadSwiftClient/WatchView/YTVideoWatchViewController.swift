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

    
    override func viewDidLoad() {
        
        // 1
        movieEmbeddedViewController                    = StoryBoardUtils.getMovieEmbeddedViewController()
        movieEmbeddedViewController?.videoID = videoID
        
        movieEmbeddedView = movieEmbeddedViewController?.view
        self.view.addSubview(movieEmbeddedView!)
        self.addChildViewController(movieEmbeddedViewController!)

//         setupViewHorizontalLayout()
    }
    
    override func viewDidLayoutSubviews() {
//        if UIDevice.currentDevice().orientation.isLandscape.boolValue { //landscape
//            setupViewHorizontalLayout()
//        } else {// portraight
//            setupViewVerticalLayout()
//        }
//        
//        movieEmbeddedView?.setNeedsLayout()
    }
    
    func setupViewVerticalLayout(){
        
    }
    
    func setupViewHorizontalLayout(){
        layout(movieEmbeddedView!) { view1 in
            
            //            view1.centerX == view1.superview!.centerX
            //            view1.centerY == view1.superview!.centerY
            
            //            view1.width   == view1.superview!.width
            //            view1.height  == view1.superview!.height
            
            view1.leading == view1.superview!.leading
            view1.top == view1.superview!.top
            
            
            view1.width   == view1.superview!.width
            view1.height  == 324
        }
    }

    
    
}
