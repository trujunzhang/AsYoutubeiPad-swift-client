//
//  MovieEmbeddedNormalBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

//    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 43)
class MovieEmbeddedNormalBarViewController: MovieEmbeddedBasedBarViewController {
    
    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!
    
    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!
    
    
    // MARK : videoPlayerView That contains avplayer
    
    @IBOutlet var videoPlayerView: AVPlayerView!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarsConstraint(topBarTopConstraint, bottomBarTopConstraint: bottomBarTopConstraint)
        
        setVideoURL(videoURL!)
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
    
    func setVideoURL(url: NSURL){
        moviePlayerViewController = MoviePlayerViewController()
        
        moviePlayerViewController?.prepareUI(durationSlider, _playPauseButton: playPauseButton, _elapsedTimeLabel: timeElapsedLabel, _remainingTimeLabel: timeRemainingLabel, _videoPlayerView: videoPlayerView)
        
        moviePlayerViewController!.initAVPlayer(url)
        moviePlayerViewController?.play()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
}




