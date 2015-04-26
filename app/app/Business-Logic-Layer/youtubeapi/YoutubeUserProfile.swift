//
//  YoutubeUserProfile.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeUserProfile: NSObject {
    var auth: GTMOAuth2Authentication!

    var userChannel: LoggedUserChannelInfo = LoggedUserChannelInfo()

    class var sharedInstance: YoutubeUserProfile {

        struct Singleton {
            static let instance = YoutubeUserProfile()
        }

        return Singleton.instance
    }

    override init() {
        super.init()

        if (userChannel.isLogin == true) {
            self.auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(keychainItemName, clientID: kMyClientID, clientSecret: kMyClientSecret)
        }

    }

    //MARK : logged user infos
    func hasLogin() -> Bool {
        return userChannel.isLogin
    }

    func saveLoggedUserChannel(channel: GTLYouTubeChannel) {
        var channelID: String = YoutubeModelParser.getAuthChannelID(channel) as String
        var title: String = YoutubeModelParser.getAuthChannelTitle(channel) as String
        var userName: String = YoutubeModelParser.getAuthChannelTitle(channel) as String

        self.userChannel.saveLoggedUserChannel(channelID, title: title, userName: userName)
    }

    func loginout() {
        self.userChannel.removeAllLoggedInfo()
    }

    func authorizeRequest(finishedWithAuth: GTMOAuth2Authentication!) {
        self.auth = finishedWithAuth

        if let theUserEmail = finishedWithAuth.userEmail {
            self.userChannel.saveFinishedWithAuth(theUserEmail)
        }

        println("self.auth \(self.auth)")
        var req: NSMutableURLRequest! = NSMutableURLRequest(URL: self.auth.tokenURL)
        self.auth.authorizeRequest(req, completionHandler: {
            (error) -> Void in
            println(self.auth)
        })
    }
}
