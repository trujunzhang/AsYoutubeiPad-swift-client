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

    func baseReset() {
       nextPageToken = ""
       hasLoadingMore = true
       isLoading = false
       hasFirstFetch = true
    }

    func makeRequestForSearchWithQueryTeam(queryTeam:NSString){


    }

}
