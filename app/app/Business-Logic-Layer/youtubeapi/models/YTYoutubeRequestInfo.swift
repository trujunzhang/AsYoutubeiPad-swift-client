//
//  GYoutubeRequestInfo.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


enum YTSegmentItemType: Int {
    case YTSegmentItemVideo = 0
    case YTSegmentItemChannel = 1
    case YTSegmentItemPlaylist = 2
}


class YTYoutubeRequestInfo: NSObject {
    var parameters: [String:String] = [String:String]()
    var videoList: NSMutableArray = NSMutableArray()
    var videoIdsPages: [AnyObject] = [AnyObject]()
    
    var nextPageToken = ""
    var hasLoadingMore = true
    var isLoading = false
    var hasFirstFetch = true
    
    var queryType: YTSegmentItemType?
    
    
    func getVideoListCount() -> Int {
        return videoList.count
    }
    
    func makeRequestForActivityListOnHomePage() {
        
    }
    
    func makeRequestForRelatedVideo(relatedToVideoId: String) {
        self.parameters = [
            "part": "snippet",
            "type": "video",
            "relatedToVideoId": relatedToVideoId,
            "fields": "items(id/videoId),nextPageToken"
        ]
        
    }
    
    func makeRequestForSearchWithQueryTeam(queryTeam: String) {
        self.queryType = .YTSegmentItemVideo
        var queryTypeString = "video"
        
        self.parameters = [
            "q": queryTeam,
            "type": queryTypeString,
            "part": "id,snippet",
            "fields": "items(id/videoId),nextPageToken",
        ]
        
    }
    
    func appendArray(array: NSArray) {
        videoList.addObjectsFromArray(array as [AnyObject])
    }
    
    func storeNextPageToken(pageToken: NSString) {
        println("pageToken in storeNextPageToken is \(pageToken)")
        self.nextPageToken = pageToken as String
    }
    
    func putNextPageToken(pageToken: String) {
        self.parameters["pageToken"] = pageToken
        //        self.parameters.setObject(pageToken, forKey: "pageToken")
    }
    
    func getPageToken() -> String {
        return self.parameters["pageToken"]!
        //        return self.parameters.objectForKey("pageToken") as! NSString
    }
    
    func hasNextPageToken() -> Bool {
        if let val = self.parameters["pageToken"] {
            return true
        }
        
        return false
    }
    
}
