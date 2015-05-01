//
//  YoutubeRetrievingActivityListItemsFetcherHelper.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


protocol RetrievingActivityListItemsFetchingHelperDelegate {
//    func failureFetchingNewsSubscriptionVideos()

    func endFetchingActivityListItems(array: NSArray)
}

class YoutubeRetrievingActivityListItemsFetcherHelper: NSObject, FetchingNextDelegate {
    var delegate: RetrievingActivityListItemsFetchingHelperDelegate?
    var playlistItemsIdsArray: NSArray?
    var fetchingStep: Int = 0

    var fetchedActivityListItems: NSMutableArray = NSMutableArray()
    var youtubeRetrievingActivityListItemsFetcher: YoutubeRetrievingActivityListItemsFetcher?

    func startFetchingplaylistItems(playlistItemsIdsArray: NSArray) {
        self.playlistItemsIdsArray = playlistItemsIdsArray

        youtubeRetrievingActivityListItemsFetcher = YoutubeRetrievingActivityListItemsFetcher()
        if let playListItemsFetcher: YoutubeRetrievingActivityListItemsFetcher = youtubeRetrievingActivityListItemsFetcher {
            playListItemsFetcher.delegate = self
        }

        fetchingNextStep()
    }

    func fetchingNextStep() {
        if (fetchingStep == playlistItemsIdsArray!.count) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingActivityListItems(fetchedActivityListItems)
            }
            return
        }

        let object: AnyObject? = self.playlistItemsIdsArray?.objectAtIndex(fetchingStep)
        var playlistID: NSString = object as! NSString
        fetchingStep++

        if let playListItemsFetcher: YoutubeRetrievingActivityListItemsFetcher = youtubeRetrievingActivityListItemsFetcher {
            playListItemsFetcher.fetchingNextActivityListItemsFromChannelList(playlistID)
        }
    }



    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        let playListItems = array as! [AnyObject]
        fetchedActivityListItems.addObjectsFromArray(playListItems)

//        println("Result in nextFetching is \(playListItems.count)")

        fetchingNextStep()
    }
}