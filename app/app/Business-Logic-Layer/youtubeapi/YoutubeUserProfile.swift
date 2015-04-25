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

public class LoggedUserChannelInfo {
    var channelID :       String = ""
    var title     :       String = ""
    var userName  :       String = ""
    var email     :       String = ""
    var isLogin   :       Bool   = false

    init(_channelID: String, _title: String, _userName: String){
        channelID = _channelID
        title     = _title
        userName  = _userName

        email     = ""
    }

    func saveFinishedWithAuth(_email: String){
        email     = _email
        isLogin   = true

        println("saving email is :\(_email)")
        Defaults[TAG_EMAIL]   = _email
        Defaults[TAG_ISLOGIN] = true
    }

    func removeAllLoggedInfo(){
        let keys:[String] = [TAG_ISLOGIN,TAG_CHANNELID,TAG_USERNAME,TAG_EMAIL]
        for key:String in keys{
            if !Defaults.hasKey(key) {
                Defaults.remove(key)
            }
        }
    }

    init(){
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
        if let theIsLogin: Bool = Defaults[TAG_ISLOGIN].bool {
            isLogin = theIsLogin
            println("saved isLogin is \(theIsLogin)")
        }
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

        if(userChannel.isLogin == true){
            self.auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName("Google", clientID: kMyClientID, clientSecret: kMyClientSecret)
        }

    }

    //MARK : logged user infos
    func hasLogin() -> Bool {
        return userChannel.isLogin
    }

    func loginout(){
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
