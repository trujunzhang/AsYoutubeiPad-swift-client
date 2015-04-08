//
//  YoutubeDataFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeDataFetcher : NSObject  {
    class var sharedInstance: YoutubeDataFetcher {
        
        struct Singleton {
            static let instance = YoutubeDataFetcher()
        }
        
        return Singleton.instance
    }
    
    
    func fetchCaptainTracks(videoID: NSString, completeHandler: ObjectHandler){
        MABYT3_VideoGoogleRequest.sharedInstance().fetchCaptainTracks(videoID, completion: { (responseInfo, error) -> Void in
            
            if (error == nil) {
                // 1
                var array:NSArray = responseInfo.array as NSArray
                
                if(array.count == 0){
                    completeHandler(array, true)
                }else{
                    var track :MABYT3_Track = array[0] as MABYT3_Track
                    if(track.lang_default == true){
                        // 2
                        self.fetchCaptainForVideo(videoID, defaultTrack: track, completeHandler: { (object, sucess) -> Void in
                            
                        })
                    }
                }
                
            }else{
                completeHandler(nil, false)
            }
        })
    }
    
    func fetchCaptainForVideo(videoID: NSString, defaultTrack: MABYT3_Track, completeHandler: ObjectHandler){
        MABYT3_VideoGoogleRequest.sharedInstance().fetchVideoTranscript(videoID, withTrack: defaultTrack, completion: { (responseInfo, error) -> Void in
            
            if (error == nil) {
                // 2
                var array:NSArray = responseInfo.array as NSArray
                
                if(array.count == 0){
                    completeHandler(array, true)
                }else{
                    
                }
                var track :MABYT3_Track = array[0] as MABYT3_Track
                var lang_default: Bool = track.lang_default
                
                completeHandler(responseInfo.array, true)
                
            }else{
                completeHandler(nil, false)
            }
        })
    }
    
}