//
//  YoutubeRetrievingGTLActivityListItemsFetcherHelper.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeRetrievingGTLActivityListItemsFetcherHelper: NSObject, FetchingNextDelegate {
    var delegate: RetrievingItemsFetchingHelperDelegate?

    var nextPageToken = ""

    var fetchedGTLActivityListItems: NSMutableArray = NSMutableArray()
    var youtubeRetrievingGTLActivityListItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher?

    func startFetchingItems() {

        youtubeRetrievingGTLActivityListItemsFetcher = YoutubeRetrievingGTLActivityListItemsFetcher()
        if let playListItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = youtubeRetrievingGTLActivityListItemsFetcher {
            playListItemsFetcher.delegate = self
        }

        fetchingNextStep()
    }

    func fetchingNextStep() {
        if (nextPageToken.isEmpty == true) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingAllItems(fetchedGTLActivityListItems)
            }
            return
        }

        if let playListItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = youtubeRetrievingGTLActivityListItemsFetcher {
            playListItemsFetcher.fetchingNextGTLActivityListItemsFromChannelList(nextPageToken)
        }
    }



    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        let playListItems = array as! [AnyObject]
        fetchedGTLActivityListItems.addObjectsFromArray(playListItems)

//        println("Result in nextFetching is \(playListItems.count)")

        fetchingNextStep()
    }
}