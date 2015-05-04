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


//    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 324) // 1.7

class MovieEmbeddedNormalBarViewController: MoviePlayerViewHelper {

    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!

    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!

    // MARK : videoPlayerView That contains avplayer

    @IBOutlet var videoPlayerView: AVPlayerView!
    @IBOutlet var subtitleLabel: UILabel!

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    // MARK : Bottom bar items

    @IBOutlet var bottomBarTopConstraint: NSLayoutConstraint!

    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!


    @IBOutlet weak var fullscreenButton: UIButton!

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
    var moviePlayerViewController: MoviePlayerViewHelper?
    lazy var playerSubtitling: YTPlayerSubtitling = {
        return YTPlayerSubtitling()
    }()
    var videoID = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        setBarsConstraint(topBarTopConstraint, bottomBarTopConstraint: bottomBarTopConstraint)

        moviePlayerViewController = self

        prepareUI(durationSlider, _playPauseButton: playPauseButton, _elapsedTimeLabel: timeElapsedLabel, _remainingTimeLabel: timeRemainingLabel, _videoPlayerView: videoPlayerView, _loadingIndicator: loadingIndicator)

        showLoadingPanel()

        if let url: NSURL = videoURL {
            setVideoURL(url, videoID: videoID)
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

    func setVideoURL(url: NSURL, videoID: String) {
        if let viewController: MoviePlayerViewHelper = moviePlayerViewController {
            playerSubtitling.setPlayer(videoID, _subtitleLabel: subtitleLabel, _moviePlayerViewController: viewController)
            viewController.initAVPlayer(url)
            viewController.play()
        }
    }

    // MARK : Events for slider
    @IBAction func sliderValueChanged(sender: AnyObject) {
        scrub(sender as! UISlider)
    }

    @IBAction func sliderBeginScrubbing(sender: AnyObject) {
        beginScrubbing(sender as! UISlider)
    }

    @IBAction func sliderEndScrubbing(sender: AnyObject) {
        endScrubbing(sender as! UISlider)
    }


    @IBAction func onClickPlayPauseButton(sender: AnyObject) {
        if let viewController: MoviePlayerViewHelper = moviePlayerViewController {
            viewController.playOrPause(sender)
        }
    }

    @IBAction func onClickFullscreenButton(sender: AnyObject) {

    }


}




