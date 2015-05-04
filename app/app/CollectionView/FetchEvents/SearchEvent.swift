//
//  SearchEventProtocol.swift
//  app
//
//  Created by djzhang on 5/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class SearchEvent: NSObject, FetchEventProtocol {
    var requestInfo = YTYoutubeRequestInfo()

    var completeHandler: ObjectHandler?

    // MARK: FetchEventProtocol
    func refreshEvent(completeHandler: ObjectHandler) {
        requestInfo =
                YoutubeFetcher.prepareRequestSearch("sketch 3", completeHandler: {
                    (object, sucess) -> Void in
                    if (sucess == true) {
                        self.requestInfo.appendArray(object as! NSArray)

                    }
                })
    }

    func endFetching() {
    }

    func nextFetching(completeHandler: ObjectHandler) {
        YoutubeFetcher.search(requestInfo, completeHandler: completeHandler)
    }

    func hasNextFetcing() -> Bool {
        return requestInfo.hasNextPageToken()
    }


}
