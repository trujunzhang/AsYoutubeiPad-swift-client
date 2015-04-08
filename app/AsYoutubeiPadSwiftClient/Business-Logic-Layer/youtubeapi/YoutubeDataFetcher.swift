//
//  YoutubeDataFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeDataFetcher {
    class var sharedInstance: YoutubeDataFetcher {
        
        struct Singleton {
            static let instance = YoutubeDataFetcher()
        }
        
        return Singleton.instance
    }
    
    
    func fetchCaptainTracks(videoID: NSString, completeHandler: ObjectHandler){
        MABYT3_VideoGoogleRequest.sharedInstance().fetchCaptainTracks(videoID, completion: { (responseInfo, error) -> Void in
            
            if (error == nil) {
                // 2
               
                

                
            }else{
                completeHandler(nil, false)
            }
        })
    }
    
}