//
//  YoutubeApiConstants.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol AuthorUserFetchingDelegate {
    func endFetchingUserChannel(channel: GTLYouTubeChannel)

    func endFetchingUserSubscriptions(array: NSArray)
}