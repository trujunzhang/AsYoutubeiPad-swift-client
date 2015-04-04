//
//  YouTubeExtractorUtils.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation



let YTVideoQualityStringSmall240   = "240"
let YTVideoQualityStringMedium360  = "360"
let YTVideoQualityStringHD720      = "720"
let YTVideoQualityStringHD1080     = "1080"
let YTVideoQualityStringUnknown    = "Unknown"


class YouTubeExtractorUtils  {
    
    class func YoutubeExtractor(videoID: NSString, completeHandler: ObjectHandler){
        IGYouTubeExtractor.sharedInstance().extractVideoForIdentifier(videoID) { (array, error) -> Void in
            if(error == nil){
                
                let convert:NSMutableDictionary = self.resolveVideoQuality(array)
                completeHandler(convert,true)
                
            }else{
                completeHandler(nil, false)
            }
        }
    }
    
    class func resolveVideoQuality(array: NSArray) -> NSMutableDictionary{
        let convert:NSMutableDictionary = NSMutableDictionary()
        
        for model in array {
            let last:IGYouTubeVideo = model as IGYouTubeVideo
            let qualityString = qualityStringForQuality(last.quality)
            
            convert.setValue(last, forKey: qualityString)
        }
        
        return convert
    }
    
    class func qualityStringForQuality(quality:IGYouTubeExtractorVideoQuality) -> NSString {
        switch(quality){
        case IGYouTubeExtractorVideoQuality.Small240:
            return YTVideoQualityStringSmall240
            
        case IGYouTubeExtractorVideoQuality.Medium360:
            return YTVideoQualityStringMedium360
            
        case IGYouTubeExtractorVideoQuality.HD720:
            return YTVideoQualityStringHD720
            
        case IGYouTubeExtractorVideoQuality.HD1080:
            return YTVideoQualityStringHD1080
            
        default:
            return YTVideoQualityStringUnknown
        }
    }
    
    
}