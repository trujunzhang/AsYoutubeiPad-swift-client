//
//  MovieEmbeddedNormalBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class MovieEmbeddedNormalBarViewController: MovieEmbeddedBasedBarViewController {
    
    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!
    
    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!
    //    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 43)
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarsConstraint(topBarTopConstraint,bottomBarTopConstraint: bottomBarTopConstraint)
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
    
    func setPlayerBars(moviePlayer : ALMoviePlayerControls){
        moviePlayer.setTwoBars(topBarPanel, withBottomBar: bottomBarPanel, withDurationSlider: durationSlider, withTimeElapsedLabel: timeElapsedLabel, withTimeRemainingLabel: timeRemainingLabel, withPlayPauseButton: playPauseButton, moviePause: "mp_embedded_pause", moviePlay: "mp_embedded_play")
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
}




