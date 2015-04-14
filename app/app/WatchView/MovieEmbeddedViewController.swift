//
//  MovieEmbeddedViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class MovieEmbeddedViewController: UIViewController {
    
    var videoID = ""
    var dict:[String:IGYouTubeVideo] = [:]
    
    var playerView: UIView?
    
    var normalBarViewController : MovieEmbeddedNormalBarViewController?
    var normalBarRootView : UIView?
    
    var group:Cartography.ConstraintGroup?
    
    // MARK : Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YoutubeExtractor()
        
        makeEmbeddedBars()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        LayoutUtils.LayoutFullView(self.view)
        layoutEmbeddedBar()
    }
    
    func makeEmbeddedBars() {
        // normal bar
        normalBarViewController = StoryBoardUtils.getMovieEmbeddedNormalBarViewController()
        
        if let controller : UIViewController = normalBarViewController{
            self.addChildViewController(controller)
        }
    }
    
    
    func playVideo(videoURL :NSURL)  {
        if let viewController : MovieEmbeddedNormalBarViewController =  normalBarViewController {
            viewController.setVideoURL(videoURL,videoID: videoID)
        }
    }
    
    
    func YoutubeExtractor(){
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            if(sucess == true){
                self.dict = object as! Dictionary
                
                // 1
                let gVideo:IGYouTubeVideo = self.dict[YTVideoQualityStringMedium360]!
                let videoURL:NSURL = gVideo.videoURL
                
                // 2.1
                self.playVideo(videoURL)
            }
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        
    }
            
    
    func layoutEmbeddedBar(){
        normalBarRootView = normalBarViewController?.view
        
        self.view.addSubview(normalBarRootView!)
        LayoutUtils.LayoutFullView(normalBarRootView!)
    }
    
    
    
}