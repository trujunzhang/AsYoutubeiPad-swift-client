//
//  YoutubeRetrievingActivityListItemsFetcher.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeRetrievingActivityListItemsFetcher: NSObject {
    var delegate: FetchingNextDelegate?

    var parameters: NSMutableDictionary = [
            "part": "snippet,contentDetails",
//            "fields": "items/contentDetails,items/snippet(publishedAt,title)",
            "fields": "items/contentDetails,items/snippet(publishedAt)",
            "maxResults": "2",
            "key": apiKey
    ]

    override init() {

    }

    func fetchingNextActivityListItemsFromChannelList(channelId: NSString) {
        parameters["channelId"] = channelId as String

        YoutubeFetcher.fetchActivityListWithoutAuth(parameters, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                var array: NSArray = object as! NSArray

                if (self.delegate != nil) {
                    self.delegate!.nextFetching(array)
                }
            }
        })

    }
}