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
    var ItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher?

    func startFetchingItems() {

        ItemsFetcher = YoutubeRetrievingGTLActivityListItemsFetcher()
        if let playListItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = ItemsFetcher {
            playListItemsFetcher.delegate = self
        }

        fetchingNextStep(true)
    }

    func fetchingNextStep(first: Bool) {
        if (first == false && nextPageToken.isEmpty == true) {
            if (self.delegate != nil) {
                self.delegate!.endFetchingAllItems(fetchedItems)
            }
            return
        }

        if let theItemsFetcher: YoutubeRetrievingGTLActivityListItemsFetcher = ItemsFetcher {
            theItemsFetcher.fetchingNextGTLActivityListItemsFromChannelList(nextPageToken)
        }
    }



    // MARK: FetchingNextDelegate
    func nextFetching(array: NSObject) {
        let items = array as! [AnyObject]
        fetchedItems.addObjectsFromArray(items)

//        println("Result in nextFetching is \(playListItems.count)")

        fetchingNextStep(false)
    }
}