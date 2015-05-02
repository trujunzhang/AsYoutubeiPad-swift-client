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

    var fetchedItems: NSMutableArray = NSMutableArray()
    var itemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher?

    func startFetchingItems() {

        itemsFetcher = YoutubeRetrievingGTLActivityListItemsFetcher()
        if let theItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = itemsFetcher {
            theItemsFetcher.delegate = self
        }

        fetchingNextStep()
    }

    func fetchingNextStep() {
        if let theItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = itemsFetcher {
            theItemsFetcher.fetchingNextGTLActivityListItemsFromChannelList(nextPageToken)
        }
    }

    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        if (self.delegate != nil) {
            self.delegate!.endFetchingAllItems(fetchedItems)
        }
    }
}