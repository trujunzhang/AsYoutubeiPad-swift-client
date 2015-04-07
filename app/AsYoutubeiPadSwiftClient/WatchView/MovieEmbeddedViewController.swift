//
//  MovieEmbeddedViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class MovieEmbeddedViewController: UIViewController,ALMoviePlayerControllerDelegate {
    
    var videoID = ""
    var dict:[String:IGYouTubeVideo] = [:]
    
    var moviePlayer : ALMoviePlayerController?
    
    var playerView: UIView?
    
    
    var normalBarViewController : MovieEmbeddedNormalBarViewController?
    var normalBarRootView : UIView?
    
    override func viewDidLoad() {
        YoutubeExtractor()
        
        setupMoviePlayer()
        
        setupEmbeddedBars()
        
        
        // add movie player to your view
        self.view.addSubview(playerView!)
        LayoutUtils.LayoutFullView(playerView!)

        
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        layoutEmbeddedBar()
    }
    
    func YoutubeExtractor(){
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            if(sucess == true){
                self.dict = object as Dictionary
                
                // 1
                let gVideo:IGYouTubeVideo = self.dict[YTVideoQualityStringMedium360]!
                let videoURL:NSURL = gVideo.videoURL
                
                // 2.1
                self.moviePlayer?.contentURL = videoURL
            }
            
        })
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    
    func setupMoviePlayer(){
        // create a movie player
        moviePlayer = ALMoviePlayerController()
        moviePlayer?.delegate = self
        
        // create the controls
        var  movieControls:ALMoviePlayerControls = ALMoviePlayerControls(moviePlayer: moviePlayer, style: ALMoviePlayerControlsStyleDefault)
        
        // optionally customize the controls here...
        movieControls.barColor = UIColor.blueColor()
        movieControls.timeRemainingDecrements = true
        movieControls.barHeight = 120
        movieControls.fadeDelay = 3.0
        movieControls.seekRate = 2.0
        
        // assign the controls to the movie player
        moviePlayer?.controls = movieControls
        
        
        // get player view
        playerView = moviePlayer!.view
    }
    
    func setupEmbeddedBars() {
        // fullscreen bar
        //        fullscreenBarViewController = StoryBoardUtils.getMovieEmbeddedFullscreenBarViewController()
        
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