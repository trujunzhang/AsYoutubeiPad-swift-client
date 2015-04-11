//
//  MovieEmbeddedNormalBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


//    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 43)
class MovieEmbeddedNormalBarViewController: MovieEmbeddedBasedBarViewController {
    
    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!
    
    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!
    
    
    // MARK : videoPlayerView That contains avplayer
    
    @IBOutlet var videoPlayerView: AVPlayerView!
    @IBOutlet var subtitleLabel: UILabel!
    
    
    // MARK : Bottom bar items
    
    @IBOutlet var bottomBarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    
    @IBOutlet var fullscreenButton: UIImageView!
    
    // MARK : Top bar items
    
    @IBOutlet var topBarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var repeatButton: UIButton!
    @IBOutlet var ccButton: UIButton!
    @IBOutlet var watchLaterButton: UIButton!
    
    // MARK : Test views
    
    @IBOutlet var animatedView: UIView!
    
    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    
    // MARK : private variables
    var videoURL: NSURL?
    var moviePlayerViewController :MoviePlayerViewController?
    var playerSubtitling : YTPlayerSubtitling?
    var videoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarsConstraint(topBarTopConstraint, bottomBarTopConstraint: bottomBarTopConstraint)
        
        moviePlayerViewController = MoviePlayerViewController()
        playerSubtitling = YTPlayerSubtitling()
        
        if let url:NSURL = videoURL {
            setVideoURL(url,videoID: videoID)
        }
        
    }
    
    // MARK : Events for Top buttons
    @IBAction func repeatButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    @IBAction func ccButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    @IBAction func watchLaterButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    func setVideoURL(url: NSURL,videoID:String){
        
        if let viewController : MoviePlayerViewController =  moviePlayerViewController {
            if let subtitling : YTPlayerSubtitling =  playerSubtitling {
                subtitling.setPlayer(videoID, _subtitleLabel: subtitleLabel, _moviePlayerViewController: viewController)
            }
            
            viewController.prepareUI(durationSlider, _playPauseButton: playPauseButton, _elapsedTimeLabel: timeElapsedLabel, _remainingTimeLabel: timeRemainingLabel, _videoPlayerView: videoPlayerView)
            
            viewController.initAVPlayer(url)
            viewController.play()
        }
    }
    
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        if let viewController : MoviePlayerViewController =  moviePlayerViewController {

            viewController.scrub(sender as! UISlider)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
}




