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
//        test02()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    func playVideo()  {
        
        let path = NSBundle.mainBundle().pathForResource("example", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        
        let videoURL = url
        moviePlayer = MPMoviePlayerViewController(contentURL: videoURL )
        
        if let player = moviePlayer {
            self.view.addSubview(player.view)
            LayoutUtils.LayoutFullView(player.view!)
        }
        else {
            NSLog("no player")
        }
    }

    
    func test02(){
        // Video file
        let filePathStr:NSString = NSBundle.mainBundle().pathForResource("example", ofType: "mp4")!
        let fileURL :NSURL = NSURL(fileURLWithPath: filePathStr)!
        
        // Subtitles file
        let subtitlesPathStr :NSString = NSBundle.mainBundle().pathForResource("example", ofType: "srt")!

        // Create MoviePlayer
        let player: MPMoviePlayerViewController = MPMoviePlayerViewController(contentURL: fileURL)
//        player.moviePlayer.openSRTFileAtPath(subtitlesPathStr, completion: { (finished) -> Void in
//            
//            // Activate subtitles
//            player.moviePlayer.showSubtitles()
//            
//            // Show video
//            self.playerView = player.view
//            // add movie player to your view
//            self.view.addSubview(self.playerView!)
//            LayoutUtils.LayoutFullView(self.playerView!)
//            
//        }) { (error) -> Void in
//            var x = 0
//        }
        
        
    }
    
    // MARK : TEST 01
    func test01(){
        //        YoutubeExtractor()
        
        setupMoviePlayer()
        
        setupEmbeddedBars()
        
        // add movie player to your view
        self.view.addSubview(playerView!)
        LayoutUtils.LayoutFullView(playerView!)
        
    }

    
    func view01(){
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
//                self.moviePlayer?.contentURL = videoURL
            }
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    
    func setupMoviePlayer(){

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