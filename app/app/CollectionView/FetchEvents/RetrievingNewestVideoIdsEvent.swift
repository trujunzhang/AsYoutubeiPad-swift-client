//
//  RetrievingNewestVideoIdsEvent.swift
//  app
//
//  Created by djzhang on 5/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class RetrievingNewestVideoIdsEvent: NSObject, FetchEventProtocol, RetrievingItemsFetchingHelperDelegate {

    let helper: YoutubeRetrievingGTLActivityListItemsFetcherHelper = YoutubeRetrievingGTLActivityListItemsFetcherHelper()

    var newestVideoIdsArray: NSArray?
    var currentPage = 0

    var completeHandler: ObjectHandler?

    // MARK: FetchEventProtocol
    func refreshEvent(object: AnyObject, completeHandler: ObjectHandler) {
        self.completeHandler = completeHandler
        helper.delegate = self
        helper.startFetchingItems()
    }

    func endFetching() {
        self.currentPage++
    }

    func nextFetching(object: AnyObject, completeHandler: ObjectHandler) {
        let object: AnyObject = self.newestVideoIdsArray!.objectAtIndex(self.currentPage)
        let videoIds: NSString = object as! NSString
        YoutubeFetcher.fetchVideoListWithVideoId(videoIds, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                // 1. array of YoutubeVideoCache
                self.endFetching()
                completeHandler(object, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

    func hasNextFetcing() -> Bool {
        let count = self.newestVideoIdsArray!.count
        if (self.currentPage >= count) {
            return false
        }

        return true
    }

    // MARK: RetrievingItemsFetchingHelperDelegate
    func endFetchingAllItems(array: NSArray) {
        let sortedArray = YoutubeParser.filterSnippetTypeIsUploadInGTLActivity(array)
        self.newestVideoIdsArray = YoutubeParser.getVideoIdsArrayByGTLActivityList(sortedArray)

        self.nextFetching("", completeHandler: self.completeHandler!)
    }


}