//
//  YoutubeRetrievingPlayListItemsFetcher.swift
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeRetrievingPlayListItemsFetcher: NSObject {
    var delegate: FetchingNextDelegate?

    var parameters: [String:String] = [
            "part": "snippet,contentDetails",
            "fields": "items/contentDetails,items/snippet(publishedAt,title)",
            "maxResults": "5",
    ]

    override init() {

    }

    func fetchingNextPlayListItemsFromChannelList(playlistID: NSString) {
        parameters["playlistId"] = playlistID as String
//        var parameters = NSMutableDictionary(dictionary: [
//                "part": "snippet,contentDetails",
//                "fields": "items/contentDetails,items/snippet(publishedAt,title)",
//                "maxResults": "5",
//                "playlistId": playlistID,
//        ]
//        )

        YoutubeFetcher.sharedInstance.fetchPlayListItemWithPlayListId(playlistID, completeHandler: {
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