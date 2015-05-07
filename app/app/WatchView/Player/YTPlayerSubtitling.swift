//
//  YTPlayerSubtitling.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/9/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class YTPlayerSubtitling :PeriodicTimeProtocol {
    
    var videoID: String = "" {
        didSet {
            fetchTracksAndCaptainForVideo(videoID)
        }
    }
    
    var moviePlayerViewController :MoviePlayerViewHelper? = nil
    
    var subtitlesParts:NSMutableDictionary? = NSMutableDictionary()
    
    var subtitleLabel : UILabel?
    
    var currentText = ""
    
    func fetchTracksAndCaptainForVideo(_videoID: String) {
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracksAndCaption(_videoID,completeHandler: { (subtitleString, sucess) -> Void in
            
            if(sucess == true){
                var subtitle:NSString = subtitleString as! NSString
                self.prepareSubtitle(subtitle as! String)
            }
        })
    }
    
    func setPlayer(_videoID: String,_subtitleLabel : UILabel ,_moviePlayerViewController: MoviePlayerViewHelper ){
        self.videoID = _videoID
        self.subtitleLabel = _subtitleLabel
        self.moviePlayerViewController = _moviePlayerViewController
    }
    
    func prepareSubtitle(subtitleString : String){
        SOSRTParserHelper().parseSRTString(subtitleString, toDictionary: subtitlesParts) { (parsed, error) -> Void in
            if(parsed == true){
                self.addToPeriodicTimeProtocol()
            }
        }
    }
    
    func addToPeriodicTimeProtocol(){
        self.moviePlayerViewController?.addPeriodicTimeProtocol(self)
    }
    
    func playerTimeChanged(){
        if let viewController : MoviePlayerViewHelper =  moviePlayerViewController {
            if let videoPlayer: AVPlayer = viewController.videoPlayer {
                if let playerItem: AVPlayerItem = videoPlayer.currentItem {
                    let time : CMTime =  playerItem.currentTime()
                    let nbSecondsElapsed: NSTimeInterval = CMTimeGetSeconds(time)
                    
                    let subtitle:NSString = SRTParserInterface.searchAndShowSubtitle(subtitlesParts, inTime: nbSecondsElapsed)
                    
                    self.updateLabel(subtitle as String)
                    
                    
                }
            }
        }
        
        
        
    }
    
    func updateLabel(subtitle: String){
        if(subtitle.isEmpty == true || subtitle == currentText){
            return
        }
        
        currentText = subtitle
        
        subtitleLabel?.text = currentText
        
        //        subtitleLabel?.text = "wanghao"
        
        subtitleLabel?.hidden = (currentText.isEmpty == true)
        
        println("player time changed : \(currentText)")
    }
    
}