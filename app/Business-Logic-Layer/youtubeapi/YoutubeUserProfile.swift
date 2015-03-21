//
//  YoutubeUserProfile.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeUserProfile : NSObject{
    var isLogin: Bool?
    
    class var sharedInstance: YoutubeUserProfile {
        struct Singleton {
            static let instance = YoutubeUserProfile()
        }
        return Singleton.instance
    }
    
    override init() {
        isLogin = false
        
        super.init()
    }
}
