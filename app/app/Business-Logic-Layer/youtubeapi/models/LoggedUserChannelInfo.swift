//
//  LoggedUserChannelInfo.swift
//  app
//
//  Created by djzhang on 4/27/15.
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
        }
        if let theChannelID: String = Defaults[TAG_CHANNELID].string {
            channelID = theChannelID
        }
        if let theUserName: String = Defaults[TAG_USERNAME].string {
            userName = theUserName
        }
        if let theEmail: String = Defaults[TAG_EMAIL].string {
            email = theEmail
        }
        if let theTitle: String = Defaults[TAG_TITLE].string {
            title = theTitle
        }
    }

    var simpleDescription: String {
        return "LoggedUserChannelInfo: channelID is \(channelID), title is \(title), userName is \(userName), email is \(email), isLogin is \(isLogin)"
    }

}
