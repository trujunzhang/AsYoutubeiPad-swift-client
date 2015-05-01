//
//  YoutubeBatchableConstant.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol FetchingNextDelegate {
    func nextFetching(array: NSObject)
}

protocol RetrievingItemsFetchingHelperDelegate {
//    func failureFetchingNewsSubscriptionVideos()

    func endFetchingAllItems(array: NSArray)
}