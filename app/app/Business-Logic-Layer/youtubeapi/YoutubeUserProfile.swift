//
//  YoutubeUserProfile.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let TAG_ISLOGIN = "hasLoggedInKey"
let TAG_CHANNELID = "author_channelid"
let TAG_USERNAME = "author_username"
let TAG_EMAIL = "author_email"
let TAG_TITLE = "author_title"

public class LoggedUserChannelInfo: NSObject, DebugPrintable, Printable {
    var channelID: String = ""
    var title: String = ""
    var userName: String = ""
    var email: String = ""
    var isLogin: Bool = false

    func saveFinishedWithAuth(_email: String) {
        email = _email
        isLogin = true

        println("saving email is :\(_email)")
        Defaults[TAG_EMAIL] = _email
        Defaults[TAG_ISLOGIN] = true
    }

    func saveLoggedUserChannel(channelID: String, title: String, userName: String) {
        self.channelID = channelID
        self.title = title
        self.userName = userName

        Defaults[TAG_CHANNELID] = channelID
        Defaults[TAG_TITLE] = title
        Defaults[TAG_USERNAME] = userName
    }

    func removeAllLoggedInfo() {
        let keys: [String] = [TAG_ISLOGIN, TAG_CHANNELID, TAG_USERNAME, TAG_EMAIL, TAG_TITLE]
        for key: String in keys {
            if !Defaults.hasKey(key) {
                Defaults.remove(key)
            }
        }
    }

    override init() {
        if let theIsLogin: Bool = Defaults[TAG_ISLOGIN].bool {
            isLogin = theIsLogin
            println("saved isLogin is \(theIsLogin)")
        }
        if let theChannelID: String = Defaults[TAG_CHANNELID].string {
            channelID = theChannelID
        }
        if let theUserName: String = Defaults[TAG_USERNAME].string {
            userName = theUserName
        }
        if let theEmail: String = Defaults[TAG_EMAIL].string {
            email = theEmail
            println("saved email is \(email)")
        }
        if let theTitle: String = Defaults[TAG_TITLE].string {
            title = theTitle
        }
    }

    var simpleDescription: String {
        return "LoggedUserChannelInfo: channelID is \(channelID), title is \(title), userName is \(userName), email is \(email), isLogin is \(isLogin)"
    }

}

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
