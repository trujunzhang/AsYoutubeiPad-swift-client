//
//  GYoutubeRequestInfo.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation



enum YTSegmentItemType :Int{
    case  YTSegmentItemVideo    = 0
    case  YTSegmentItemChannel  = 1
    case  YTSegmentItemPlaylist = 2
}

//enum YTPlaylistItemsType :Int{
//}

class YTYoutubeRequestInfo: NSObject {
    var parameters = NSMutableDictionary()
    var videoList = NSMutableArray()
    
    var nextPageToken    = ""
    var hasLoadingMore   = true
    var isLoading        = false
    var hasFirstFetch    = true
    
    var queryType        : YTSegmentItemType?
    
    
    func getVideoListCount() -> Int {
        return videoList.count
    }
    
    
    func makeRequestForRelatedVideo(relatedToVideoId:NSString){
        var _parameters = [
            "part" : "snippet",
            "type" : "video",
            "relatedToVideoId":relatedToVideoId,
            "fields" : "items(id/videoId),nextPageToken"
        ]
        
        self.parameters.setDictionary(_parameters)
    }
    
    func makeRequestForSearchWithQueryTeam(queryTeam:NSString){
        self.queryType = .YTSegmentItemVideo
        var queryTypeString = "video"
        
        var _parameters = [
            "q" : queryTeam,
            "type" : queryTypeString,
            "part" : "id,snippet",
            "fields" : "items(id/videoId),nextPageToken",
        ]
        
        self.parameters.setDictionary(_parameters)
    }
    
    func appendArray(array:NSArray){
        videoList.addObjectsFromArray(array as [AnyObject])
    }
    
    func putNextPageToken(pageToken:NSString){
        //        if(pageToken == nil || pageToken.isEqualToString("") == true) {
        //            hasLoadingMore = NO;
        //            return;
        //        }
        
        //        if(nextPageToken.isEqualToString("") == false && pageToken.isEqualToString(nextPageToken) == true) {
        //            hasLoadingMore = NO;
        //        }
        //
        //        if(nextPageToken.isEqualToString("") == true) { // First request
        //            nextPageToken = pageToken;
        //        }
        
        self.parameters.setObject(pageToken, forKey: "pageToken")
    }
    
    func getPageToken() -> NSString{
        return self.parameters.objectForKey("pageToken") as! NSString
    }
    
}
