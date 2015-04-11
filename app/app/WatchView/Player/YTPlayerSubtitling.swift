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
    
    var moviePlayerViewController :MoviePlayerViewController? = nil
    
    var subtitlesParts:NSMutableDictionary? = NSMutableDictionary()
    
    var subtitleLabel : UILabel?
    
    var currentText = ""
    
    init(){
        
    }
    
    func fetchTracksAndCaptainForVideo(_videoID: String) {
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracksAndCaption(_videoID,completeHandler: { (subtitleString, sucess) -> Void in
            
            if(sucess == true){
                var subtitle:NSString = subtitleString as! NSString
                self.prepareSubtitle(subtitle as! String)
            }
            
        })
        
    }
    
    func setPlayer(_videoID: String,_subtitleLabel : UILabel ,_moviePlayerViewController: MoviePlayerViewController ){
        fetchTracksAndCaptainForVideo(_videoID)
        
        videoID = _videoID
        subtitleLabel = _subtitleLabel
        moviePlayerViewController = _moviePlayerViewController
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
         if let viewController : MoviePlayerViewController =  moviePlayerViewController {
            if let videoPlayer: AVPlayer = viewController.videoPlayer {
                if let playerItem: AVPlayerItem = videoPlayer.currentItem {
                    let time : CMTime =  playerItem.currentTime()
                    let nbSecondsElapsed: NSTimeInterval = CMTimeGetSeconds(time)
                    
                    
                    let subtitle:NSString = SRTParserInterface.searchAndShowSubtitle(subtitlesParts, inTime: nbSecondsElapsed)
                    
                    if (subtitle.isEqualToString(currentText) || subtitle == currentText){
                        return
                    }
                    currentText = subtitle as String
                    
                    //                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                    // updateLabel
                    //                    self.updateLabel()
                    //                })
                    
                    self.updateLabel()
                    
                    println("player time changed : \(currentText)")
                }
            }
        }

        
        
    }
    
    func updateLabel(){
        
        subtitleLabel?.text = currentText
        
        //        subtitleLabel?.text = "wanghao"
        
        subtitleLabel?.hidden = currentText.isEmpty == false
    }
    
}