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
    
    
    func setPlayer(_player: AVPlayer, _videoID: String){
        player = _player
        videoID = _videoID
        
    }
    
    func playerTimeChanged(){
        
    }
    
}