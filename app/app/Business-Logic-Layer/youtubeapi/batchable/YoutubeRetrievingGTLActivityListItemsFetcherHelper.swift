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
            theItemsFetcher.fetchingNextGTLActivityListItemsFromChannelList()
        }
    }

    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        if (self.delegate != nil) {
            var fetchedItems: NSArray = array as! NSArray
            self.delegate!.endFetchingAllItems(fetchedItems)
        }
    }
}