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
    var channelIDsArray: NSArray?
    var fetchingStep :Int = 0

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
        if (fetchingStep == channelIDsArray!.count) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingNewSubscriptionVideos(fetchedChannels)
            }
            return
        }
        
        let object: AnyObject? = self.channelIDsArray?.objectAtIndex(fetchingStep)
        var channelIDs: NSString = object  as! NSString
        fetchingStep++
        
        if let newSubscriptionVideosFetcher: YoutubeRetrievingNewSubscriptionVideosFetcher = youtubeRetrievingNewSubscriptionVideosFetcher {
            newSubscriptionVideosFetcher.fetchingNextUploadsIdFromChannelList(channelIDs)
        }
    }



    // MARK: RetrievingNewSubscriptionVideosFetchingDelegate
    func nextFetching(array: NSObject) {
        fetchedChannels.addObjectsFromArray(array as! [AnyObject])

        fetchingNextStep()
    }
}