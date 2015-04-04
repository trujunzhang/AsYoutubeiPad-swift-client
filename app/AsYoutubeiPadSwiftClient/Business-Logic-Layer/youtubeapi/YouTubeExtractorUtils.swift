//
//  YouTubeExtractorUtils.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation



class YouTubeExtractorUtils  {
    
    
    class func YoutubeExtractor(videoID: NSString, completeHandler: ObjectHandler){
        IGYouTubeExtractor.sharedInstance().extractVideoForIdentifier(videoID) { (array, error) -> Void in
            if(error == nil){
                completeHandler(array,true)
            }else{
                 completeHandler(nil, false)
            }
        }
        
    }
    
    
}