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
        
        self.view.backgroundColor = UIColor.redColor()
    }
    
    func YoutubeExtractor(){
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            if(sucess == true){
                self.dict = object as Dictionary
                
                var x = 0
            }
            
        })
    }
    
    func setupMoviePlayer(){
        moviePlayer = ALMoviePlayerController(frame: self.view.frame)
        
    }
    
    // MARK : protocol for ALMoviePlayerControllerDelegate
    func moviePlayerWillMoveFromWindow(){
        
    }
    
    
}