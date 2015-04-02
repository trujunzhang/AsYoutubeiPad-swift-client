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
    var parameters: NSMutableDictionary?
    
    var nextPageToken    : NSString?
    var hasLoadingMore   : Bool?
    var isLoading        : Bool?
    var hasFirstFetch    : Bool?
    
    var queryType        : YTSegmentItemType?
    var queryTypeString  : NSString?
    
    func baseReset() {
        nextPageToken = ""
        hasLoadingMore = true
        isLoading = false
        hasFirstFetch = true
    }
    
    func makeRequestForSearchWithQueryTeam(queryTeam:NSString){
        self.baseReset()
        
        self.queryType = .YTSegmentItemVideo
        self.queryTypeString = "video"
        
//        var fieldsValue:NSString = "items(id/videoId),nextPageToken"
//        var _parameters:NSMutableDictionary = [
//            "q" : queryTeam,
//            "type" : self.queryTypeString,
//            "part" : "id,snippet",
//            "fields" : fieldsValue,
//        ]
        
        self.parameters = NSMutableDictionary()
        
        self.parameters?.setObject(queryTeam, forKey: "q")
        self.parameters?.setObject("id,snippet", forKey: "part")
        self.parameters?.setObject(self.queryTypeString!, forKey: "type")
        self.parameters?.setObject("items(id/videoId),nextPageToken", forKey: "fields")
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
        
        self.parameters?.setObject(pageToken, forKey: "pageToken")
    }
    
    func getPageToken() -> NSString{
        return self.parameters?.objectForKey("pageToken") as NSString
    }
    
}
