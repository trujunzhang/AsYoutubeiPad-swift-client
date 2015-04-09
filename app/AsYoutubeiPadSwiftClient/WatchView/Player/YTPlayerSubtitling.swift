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
    
    func setPlayer(_moviePlayerViewController: MoviePlayerViewController, _videoID: String){
        moviePlayerViewController = _moviePlayerViewController
        videoID = _videoID
        
        prepareSubtitle()
    }
    
    func prepareSubtitle(){
        
    }
    
    func playerTimeChanged(){
        
    }
    
}