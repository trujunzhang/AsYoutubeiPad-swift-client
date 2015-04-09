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
    var videoID = ""
    
    var player: AVPlayer? = nil
    var moviePlayerViewController :MoviePlayerViewController? = nil
    var subtitlesParts:NSMutableDictionary? = NSMutableDictionary()
    
    var subtitleLabel : UILabel?
    
    var currentText: NSString = ""
    
    init(){
        
    }
    
    func setPlayer(_moviePlayerViewController: MoviePlayerViewController, _videoID: String){
        videoID = _videoID
        moviePlayerViewController = _moviePlayerViewController
        
        player = moviePlayerViewController?.videoPlayer
        
        let subtitleString : String = Tools.readFile("example")
        prepareSubtitle(subtitleString)
    }
    
    func prepareSubtitle(subtitleString : String){
        
        let srtParser:SOSRTParserHelper = SOSRTParserHelper()
        
        srtParser.parseSRTString(subtitleString, toDictionary: subtitlesParts) { (parsed, error) -> Void in
            if(parsed == true){
                self.addToPeriodicTimeProtocol()
            }
        }
        
    }
    
    func addToPeriodicTimeProtocol(){
        self.moviePlayerViewController?.addPeriodicTimeProtocol(self)
    }
    
    func playerTimeChanged(){
        if let videoPlayer: AVPlayer = player {
            if let playerItem: AVPlayerItem = videoPlayer.currentItem {
                let time : CMTime =  playerItem.currentTime()
                let nbSecondsElapsed: NSTimeInterval = CMTimeGetSeconds(time)
                
                
                let subtitle:NSString = SRTParserInterface.searchAndShowSubtitle(subtitlesParts, inTime: nbSecondsElapsed)
                
                if (subtitle.isEqualToString(currentText) || subtitle == currentText){
                    return
                }
                currentText = subtitle                
            }
        }
        
        
        
    }
    
}