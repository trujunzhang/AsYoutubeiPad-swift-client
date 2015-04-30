//
//  YoutubeRetrievingNewSubscriptionVideosFetcher
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol RetrievingNewSubscriptionVideosFetchingDelegate {
    func endFetchingUserChannel(channel: GTLYouTubeChannel)
    
    func endFetchingUserSubscriptions(array: NSArray)
}

class YoutubeRetrievingNewSubscriptionVideosFetcher :NSObject {
    
}