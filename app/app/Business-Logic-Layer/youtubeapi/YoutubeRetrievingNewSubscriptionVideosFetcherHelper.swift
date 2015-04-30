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

class YoutubeRetrievingNewSubscriptionVideosFetcherHelper: NSObject, FetchingNextDelegate {
    var delegate: RetrievingNewSubscriptionVideosFetchingHelperDelegate?
    var channelIDsArray: NSArray?
    var fetchingStep: Int = 0

    var fetchedChannels: NSMutableArray = NSMutableArray()
    var youtubeRetrievingNewSubscriptionVideosFetcher: YoutubeRetrievingNewSubscriptionVideosFetcher?

    func startFetchingNewSubscriptionVideos(channelIDsArray: NSArray) {
        self.channelIDsArray = channelIDsArray

        youtubeRetrievingNewSubscriptionVideosFetcher = YoutubeRetrievingNewSubscriptionVideosFetcher()
        if let newSubscriptionVideosFetcher: YoutubeRetrievingNewSubscriptionVideosFetcher = youtubeRetrievingNewSubscriptionVideosFetcher {
            newSubscriptionVideosFetcher.delegate = self
        }

        fetchingNextStep()
    }

    func fetchingNextStep() {
//        if (fetchingStep == channelIDsArray!.count) {// used
        if (fetchingStep == 1) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingNewSubscriptionVideos(fetchedChannels)
            }
            return
        }

        let object: AnyObject? = self.channelIDsArray?.objectAtIndex(fetchingStep)
        var channelIDs: NSString = object as! NSString
        fetchingStep++

        if let newSubscriptionVideosFetcher: YoutubeRetrievingNewSubscriptionVideosFetcher = youtubeRetrievingNewSubscriptionVideosFetcher {
            newSubscriptionVideosFetcher.fetchingNextUploadsIdFromChannelList(channelIDs)
        }
    }



    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        let channels = array as! [AnyObject]
        fetchedChannels.addObjectsFromArray(channels)

        println("Result in nextFetching is \(channels.count)")

        fetchingNextStep()
    }
}