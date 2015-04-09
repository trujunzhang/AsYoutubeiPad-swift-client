//
//  MovieEmbeddedViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class MovieEmbeddedViewController: UIViewController {
    
    var videoID = ""
    var dict:[String:IGYouTubeVideo] = [:]
    
    var playerView: UIView?
    
    var normalBarViewController : MovieEmbeddedNormalBarViewController?
    var normalBarRootView : UIView?
    
    // MARK : Life-Cycle
    override func viewDidLoad() {
        
        test01()
        
        //        let path = NSBundle.mainBundle().pathForResource("example", ofType:"mp4")
        //        let videoURL :NSURL = NSURL.fileURLWithPath(path!)!
        //        playVideo(videoURL)
        
        layoutEmbeddedBar()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    func playVideo(videoURL :NSURL)  {
        if let viewController : MovieEmbeddedNormalBarViewController =  normalBarViewController {
            viewController.setVideoURL(videoURL)
        }
    }
    
    
    // MARK : TEST 01
    func test01(){
        YoutubeExtractor()
        
        setupEmbeddedBars()
        
        // add movie player to your view
        //        self.view.addSubview(playerView!)
        //        LayoutUtils.LayoutFullView(playerView!)
        
    }
    
    
    
    func YoutubeExtractor(){
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            if(sucess == true){
                self.dict = object as Dictionary
                
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
    
    
    
    func setupEmbeddedBars() {
        // normal bar
        normalBarViewController = StoryBoardUtils.getMovieEmbeddedNormalBarViewController()
        self.addChildViewController(normalBarViewController!)
    }
    
    func layoutEmbeddedBar(){
        normalBarRootView = normalBarViewController?.view
        
        self.view.addSubview(normalBarRootView!)
        LayoutUtils.LayoutFullView(normalBarRootView!)
        
    }
    
    
    // MARK : protocol for ALMoviePlayerControllerDelegate
    func moviePlayerWillMoveFromWindow(){
        
    }
    
    
}