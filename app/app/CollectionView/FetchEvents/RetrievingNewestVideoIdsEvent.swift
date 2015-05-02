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

    // MARK: FetchEventProtocol
    func startFetching() {
        helper.delegate = self
        helper.startFetchingItems()
    }

    func endFetching() {
        self.currentPage++
    }

    func nextFetching() {

    }

    func hasNextFetcing() -> Bool {
        if (self.currentPage >= self.newestVideoIdsArray.count) {
            return false
        }
        return true
    }

    // MARK: RetrievingItemsFetchingHelperDelegate
    func endFetchingAllItems(array: NSArray) {
        let sortedArray = YoutubeParser.filterSnippetTypeIsUploadInGTLActivity(array)
        self.newestVideoIdsArray = YoutubeParser.getVideoIdsArrayByGTLActivityList(sortedArray)

//        println("count of sortedArray is \(sortedArray.count)")
//        println("newestVideoIdsArray is \(newestVideoIdsArray)")
    }


}