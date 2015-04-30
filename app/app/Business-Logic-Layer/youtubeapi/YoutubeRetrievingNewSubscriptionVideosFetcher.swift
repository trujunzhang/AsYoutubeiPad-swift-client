//
//  YoutubeRetrievingNewSubscriptionVideosFetcher
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeRetrievingNewSubscriptionVideosFetcher: NSObject {
    var delegate: FetchingNextDelegate?

    func fetchingNextUploadsIdFromChannelList(channelIDs: NSString) {

        YoutubeFetcher.sharedInstance.fetchingUploadsIdFromChannelList(channelIDs, completeHandler: {
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