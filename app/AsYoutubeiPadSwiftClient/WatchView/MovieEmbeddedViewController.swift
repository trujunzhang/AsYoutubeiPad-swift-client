//
//  MovieEmbeddedViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class MovieEmbeddedViewController: UIViewController,ALMoviePlayerControllerDelegate {
    
    var videoID = ""
    var dict:[String:IGYouTubeVideo] = [:]
    
    // v1.0
    var moviePlayer : ALMoviePlayerController?
    
    
    var playerView: UIView?
    
    override func viewDidLoad() {
        YoutubeExtractor()
        
        setupMoviePlayer()
        
        // add movie player to your view
        self.view.addSubview(playerView!)
        
        self.view.backgroundColor = UIColor.redColor()
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
        layout(self.playerView!) { view1 in
            
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            
            view1.top   == view1.superview!.top
            view1.bottom  == view1.superview!.bottom
        }
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
    
    
    
    
    // MARK : protocol for ALMoviePlayerControllerDelegate
    func moviePlayerWillMoveFromWindow(){
        
    }
    
    
}