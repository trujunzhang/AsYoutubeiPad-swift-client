//
//  MoviePlayerViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/9/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class MoviePlayerViewController : PeriodicTimeProtocol {
    
    var seekber: UISlider!
    var playPauseButton: UIButton!
    var elapsedTimeLabel: UILabel!
    var remainingTimeLabel: UILabel!
    var videoPlayerView: AVPlayerView!
    
    
    var playerItem: AVPlayerItem? = nil
    var videoPlayer: AVPlayer? = nil
    var videoTimeObserver: AnyObject? = nil
    var playingRateAfterScrub: Float = 0
    
    // MARK : array of PeriodicTimeProtocol
    var periodicTimeProtocols:[PeriodicTimeProtocol] = [PeriodicTimeProtocol]()
    
    
    // MARK: - View Lifecycle
    
    init(){
        
    }
    
    func prepareUI(_seekber: UISlider,_playPauseButton: UIButton, _elapsedTimeLabel: UILabel, _remainingTimeLabel: UILabel, _videoPlayerView: AVPlayerView){
        seekber = _seekber;
        playPauseButton = _playPauseButton;
        elapsedTimeLabel = _elapsedTimeLabel;
        remainingTimeLabel = _remainingTimeLabel;
        
        videoPlayerView = _videoPlayerView;
    }
    
    func initAVPlayer(url: NSURL){
        
        self.playerItem = AVPlayerItem(URL: url)
        
        self.videoPlayer = AVPlayer(playerItem: self.playerItem)
        
        self.videoPlayerView.setPlayer(self.videoPlayer!)
        self.videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspect)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)
        
        
        self.videoTimeObserver = self.videoPlayer!.addPeriodicTimeObserverForInterval(CMTimeMake(150, 600),
            queue: dispatch_get_main_queue(),
            usingBlock: {[unowned self](CMTime) in
                
                self.runPeriodicTimes()
                
            })
        
        self.seekber.minimumTrackTintColor = UIColor.whiteColor()
        self.seekber.maximumTrackTintColor = UIColor.blackColor()
        self.seekber.setValue(0, animated: false)
        self.syncPlayPauseButtonImage()
        self.updateTimeLabel()
        
        self.addPeriodicTimeProtocol(self)
        
        //        self.singleTap.requireGestureRecognizerToFail(self.doubleTap)
    }
    
    
    // MARK: - Player Notifications
    
    func playerItemDidReachEnd(notification: NSNotification) {
        self.syncPlayPauseButtonImage()
        self.seekToTime(0)
    }
    
    
    // MARK: - Player Item
    
    func isPlaying() -> Bool {
        return playingRateAfterScrub != 0 || self.videoPlayer!.rate != 0
    }
    
    func playerItemDuration() -> CMTime {
        let playerItem: AVPlayerItem = self.videoPlayer!.currentItem
        if playerItem.status == .ReadyToPlay {
            return playerItem.duration
        }
        
        return kCMTimeInvalid
    }
    
    
    // MARK: - Player Appearance
    
    func syncSeekber() {
        let playerDuration: CMTime = self.playerItemDuration()
        
        if !playerDuration.isValid {
            self.seekber.minimumValue = 0
            return
        }
        
        let duration: Double = CMTimeGetSeconds(playerDuration)
        let currentTime: Double = CMTimeGetSeconds(self.videoPlayer!.currentTime())
        
        let progress: Float = Float(currentTime/duration)
        self.seekber.setValue(progress, animated: true)
    }
    
    func updateTimeLabel() {
        let playerDuration: CMTime = self.playerItemDuration()
        
        if !playerDuration.isValid {
            return
        }
        
        let duration: Double = CMTimeGetSeconds(playerDuration)
        let currentTime: Double = CMTimeGetSeconds(self.videoPlayer!.currentTime())
        
        let elapsedTimeMin: Int = Int(currentTime/60)
        let elapsedTimeSec: Int = Int(currentTime) - elapsedTimeMin*60
        
        let remainingTimeMin: Int = Int((duration - currentTime)/60)
        let remainingTimeSec: Int = Int(duration - currentTime) - remainingTimeMin*60
        
        self.elapsedTimeLabel.text = getTimeString(elapsedTimeMin,timeSec: elapsedTimeSec)
        self.self.remainingTimeLabel.text = getTimeString(remainingTimeMin,timeSec: remainingTimeSec)
    }
    
    func getTimeString(timeMin: Int,timeSec: Int) -> String {
        let min_p:String = String(format: "%02d", timeMin);
        let sec_p:String = String(format: "%02d", timeSec);
        
        return "\(min_p):\(sec_p)"
    }
    
    
    // MARK: - Play & Pause
    
    func play() {
        self.videoPlayer!.play()
    }
    
    func pause() {
        self.videoPlayer!.pause()
    }
    
    //    @IBAction
    func playOrPause(sender: AnyObject) {
        if self.isPlaying() {
            self.pause()
        } else {
            self.play()
        }
        
        self.syncPlayPauseButtonImage()
    }
    
    func syncPlayPauseButtonImage() {
        if self.isPlaying() {
            self.playPauseButton.setImage(UIImage(named:"pause.png"), forState: .Normal)
        } else {
            self.playPauseButton.setImage(UIImage(named:"play.png"), forState: .Normal)
        }
    }
    
    
    // MARK: - Seek
    
    //    @IBAction
    func beginScrubbing(slider: UISlider) {
        self.playingRateAfterScrub = self.videoPlayer!.rate
        self.pause()
    }
    
    //    @IBAction
    func endScrubbing(slider: UISlider) {
        if self.playingRateAfterScrub != 0 {
            self.play()
            self.playingRateAfterScrub = 0
        }
    }
    
    //    @IBAction
    func scrub(slider: UISlider) {
        self.seekToTime(Double(slider.value))
    }
    
    func isScrubbing() -> Bool {
        return playingRateAfterScrub != 0;
    }
    
    
    //    @IBAction
    func back() {
        self.seekToTime(0)
    }
    
    //    @IBAction
    func next() {
        self.seekToTime(1)
    }
    
    func seekToTime(position: Double) {
        let playerDuration: CMTime = self.playerItemDuration()
        
        if !playerDuration.isValid {
            self.seekber.minimumValue = 0
            return
        }
        
        let duration: Double  = CMTimeGetSeconds(playerDuration);
        
        let currentTime: Double = CMTimeGetSeconds(videoPlayer!.currentTime())
        if (currentTime <= 0 && position == 0) || (currentTime >= duration && position == 1) {
            return;
        }
        
        let time: Double = duration * position
        self.videoPlayer!.seekToTime(CMTimeMakeWithSeconds(time, Int32(NSEC_PER_SEC)))
    }
    
    // MARK: - Tap Gesture
    //    @IBAction
    func hideMenu() {
        //        if self.playerMenu.hidden {
        //            self.playerMenu.hidden = false
        //            UIView.animateWithDuration(0.25, animations: {
        //                self.playerMenu.alpha = 1
        //            })
        //
        //        } else {
        //            UIView.animateWithDuration(0.25, animations: {
        //                self.playerMenu.alpha = 0
        //                }, completion: { (value: Bool) in
        //                    self.playerMenu.hidden = true
        //            })
        //        }
    }
    
    //    @IBAction
    func zoomPlayer() {
        if self.videoPlayerView.videoFillMode() == AVLayerVideoGravityResizeAspect {
            self.videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspectFill)
        } else {
            self.videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspect)
        }
    }
    
    // MARK :
    func playerTimeChanged(){
        self.syncSeekber()
        self.updateTimeLabel()
    }
    
    func runPeriodicTimes(){
        
        let _periodicTimeProtocols: [PeriodicTimeProtocol] = self.periodicTimeProtocols
        
        for periodicTimeProtocol in _periodicTimeProtocols{
            
            let _periodicTimeProtocol: PeriodicTimeProtocol = periodicTimeProtocol as PeriodicTimeProtocol
            _periodicTimeProtocol.playerTimeChanged()
            
        }
        
        
    }
    
    func addPeriodicTimeProtocol(periodicTimeProtocol:PeriodicTimeProtocol){
        periodicTimeProtocols.append(periodicTimeProtocol)
    }
    
    
    
}