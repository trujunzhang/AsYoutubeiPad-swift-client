//
//  YoutubeRetrievingNewSubscriptionVideosFetcherHelper.swift
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol RetrievingNewSubscriptionVideosFetchingHelperDelegate {
//    func failureFetchingNewsSubscriptionVideos()

    func endFetchingNewSubscriptionVideos(array: NSArray)
}

class YoutubeRetrievingNewSubscriptionVideosFetcherHelper: NSObject, RetrievingNewSubscriptionVideosFetchingDelegate {
    var delegate: RetrievingNewSubscriptionVideosFetchingHelperDelegate?

    func startFetchingNewSubscriptionVideos(channelIDsArray: NSArray) {

    }

    // MARK: RetrievingNewSubscriptionVideosFetchingDelegate
    func nextFetching(array: NSObject) {

    }
}