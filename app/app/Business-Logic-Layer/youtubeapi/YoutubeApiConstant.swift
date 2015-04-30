//
//  YoutubeApiConstant.swift
//  app
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let myChannelId = "UC0wObT_HayGfWLdRAnFyPwA"
let baseURLString = "https://www.googleapis.com/youtube/v3"

let apiKey            = "AIzaSyBd9kf5LB41bYWnxI3pfoxHJ2njRvmAA90"
let kMyClientID       = "632947002586-hsu569tme6lt8635vvoofi5mnkqfkqus.apps.googleusercontent.com"
let kMyClientSecret   = "dHWxjaetid5ckoVMzp0LmzJt"
let keychainItemName  = "eTube-client"
// let scope             = "https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload"

let scope             = "https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly"

typealias ObjectHandler = (AnyObject!, Bool!) -> Void



protocol FetchingNextDelegate {
    func nextFetching(array: NSObject)
}