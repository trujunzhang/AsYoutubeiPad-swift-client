//
//  SuggestionVideoListTask.swift
//  app
//
//  Created by djzhang on 5/7/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class SuggestionVideoListTask {
    
    var requestInfo = YTYoutubeRequestInfo()
    
    // MARK: FetchTaskProtocol
    func refreshEvent(object: AnyObject, completeHandler: ObjectHandler) {
        let videoID = object as! String
        requestInfo =
            YoutubeFetcher.prepareFetchingRelativeVideos(videoID, completeHandler: {
                (object, sucess) -> Void in
                if (sucess == true) {
                    self.requestInfo.appendArray(object as! NSArray)
                    completeHandler(object, true)
                }
            })
    }
    
    func endFetching() {
    }
    
    func nextFetching(object: AnyObject, completeHandler: ObjectHandler) {
        YoutubeFetcher.search(requestInfo, completeHandler: completeHandler)
    }
    
    func hasNextFetcing() -> Bool {
        return requestInfo.hasNextPageToken()
    }
    
}