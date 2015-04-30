//
//  YoutubeRetrievingPlayListItemsFetcherHelper.swift
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


protocol RetrievingPlayListItemsFetchingHelperDelegate {
//    func failureFetchingNewsSubscriptionVideos()

    func endFetchingPlayListItems(array: NSArray)
}

class YoutubeRetrievingPlayListItemsFetcherHelper: NSObject, FetchingNextDelegate {
    var delegate: RetrievingPlayListItemsFetchingHelperDelegate?
    var playlistItemsIdsArray: NSArray?
    var fetchingStep: Int = 0

    var fetchedPlayListItems: NSMutableArray = NSMutableArray()
    var youtubeRetrievingPlayListItemsFetcher: YoutubeRetrievingPlayListItemsFetcher?

    func startFetchingplaylistItems(playlistItemsIdsArray: NSArray) {
        self.playlistItemsIdsArray = playlistItemsIdsArray

        youtubeRetrievingPlayListItemsFetcher = YoutubeRetrievingPlayListItemsFetcher()
        if let playListItemsFetcher: YoutubeRetrievingPlayListItemsFetcher = youtubeRetrievingPlayListItemsFetcher {
            playListItemsFetcher.delegate = self
        }

        fetchingNextStep()
    }

    func fetchingNextStep() {
        if (fetchingStep == playlistItemsIdsArray!.count) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingPlayListItems(fetchedPlayListItems)
            }
            return
        }

        let object: AnyObject? = self.playlistItemsIdsArray?.objectAtIndex(fetchingStep)
        var playlistID: NSString = object as! NSString
        fetchingStep++

        if let playListItemsFetcher: YoutubeRetrievingPlayListItemsFetcher = youtubeRetrievingPlayListItemsFetcher {
            playListItemsFetcher.fetchingNextPlayListItemsFromChannelList(playlistID)
        }
    }



    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        let playListItems = array as! [AnyObject]
        fetchedPlayListItems.addObjectsFromArray(playListItems)

        println("Result in nextFetching is \(playListItems.count)")

        fetchingNextStep()
    }
}