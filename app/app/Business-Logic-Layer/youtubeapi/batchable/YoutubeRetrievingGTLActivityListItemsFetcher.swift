//
//  YoutubeRetrievingGTLActivityListItemsFetcher.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeRetrievingGTLActivityListItemsFetcher: NSObject {
    var delegate: FetchingNextDelegate?
    var requestInfo: YTYoutubeRequestInfo?

    override init() {
    }

    func fetchingNextGTLActivityListItemsFromChannelList(nextPageToken: String) {
        requestInfo = AuthoredFetcher.sharedInstance.prepareFetchingActivityListOnHomePage {
            (object, sucess) -> Void in

            if (sucess == true) {
                var array: NSArray = object as! NSArray
                if (self.delegate != nil) {
                    self.delegate!.nextFetching(array)
                }
            }

            println("array in fetchingNextGTLActivityListItemsFromChannelList is \(object.count)")
        }

//        AuthoredFetcher.sharedInstance.prepareFetchingGTLActivityListOnHomePage({

//        YoutubeFetcher.fetchGTLActivityListWithoutAuth(parameters, completeHandler: {
//            (object, sucess) -> Void in
//
//            if (sucess == true) {
//                var array: NSArray = object as! NSArray
//

//            }
//        })

    }
}