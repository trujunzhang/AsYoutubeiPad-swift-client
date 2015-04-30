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

    func fetchingNextPlayListItemsFromChannelList(playlistID: NSString) {

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