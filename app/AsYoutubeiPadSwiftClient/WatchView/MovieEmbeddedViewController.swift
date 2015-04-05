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
    
    var moviePlayer : ALMoviePlayerController?
    
    override func viewDidLoad() {
        YoutubeExtractor()
        
        setupMoviePlayer()
        
        self.view.backgroundColor = UIColor.redColor()
    }
    
    func YoutubeExtractor(){
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            if(sucess == true){
                self.dict = object as Dictionary
                
                let gVideo:IGYouTubeVideo = self.dict[YTVideoQualityStringMedium360]!
                let videoURL:NSURL = gVideo.videoURL
                
                self.moviePlayer?.contentURL = videoURL
                layout(self.moviePlayer!.view!) { view1 in
                    
                    view1.centerX == view1.superview!.centerX
                    view1.centerY == view1.superview!.centerY
                    
                    view1.width   == view1.superview!.width
                    view1.height  == view1.superview!.height
                    
                }
            }
            
        })
    }
    
    func setupMoviePlayer(){
        // create a movie player
        moviePlayer = ALMoviePlayerController()
        moviePlayer?.delegate = self
        
        // create the controls
        var  movieControls:ALMoviePlayerControls = ALMoviePlayerControls(moviePlayer: moviePlayer, style: ALMoviePlayerControlsStyleFullscreen)
        
        // assign the controls to the movie player
        moviePlayer?.controls = movieControls
        
        // add movie player to your view
        self.view.addSubview(moviePlayer!.view)
        

    }
    
    // MARK : protocol for ALMoviePlayerControllerDelegate
    func moviePlayerWillMoveFromWindow(){
        
    }
    
    
}