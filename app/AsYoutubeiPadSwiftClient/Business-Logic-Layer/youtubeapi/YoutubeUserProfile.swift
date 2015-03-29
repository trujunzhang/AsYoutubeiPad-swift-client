//
//  YoutubeUserProfile.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


public struct LoggedUserChannelInfo {
    var channelID :       String
    var title :           String
    var userName :        String
}

class YoutubeUserProfile: NSObject {
    var isLogin: Bool?
    var auth: GTMOAuth2Authentication!
    
    var userChannel: LoggedUserChannelInfo?
    
    class var sharedInstance: YoutubeUserProfile {
        
        struct Singleton {
            static let instance = YoutubeUserProfile()
        }
        
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
        isLogin = self.hasLogin()
        //        isLogin = true
        
        userChannel = LoggedUserChannelInfo(channelID: "", title: "", userName: "")
        
        if(isLogin == true){
            self.auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName("Google", clientID: kMyClientID, clientSecret: kMyClientSecret)
            
            userChannel = self.loadLoggedUserChannelInfo()
        }
        
    }
    
    //MARK :
    func loadLoggedUserChannelInfo() ->LoggedUserChannelInfo {
        var _userChannel: LoggedUserChannelInfo?
        
        _userChannel = LoggedUserChannelInfo(channelID: "", title: "", userName: "")
        
        return _userChannel!
    }
    
    func saveLoggedUserChannelInfo(channelID : String,title :  String,userName : String){
        userChannel = LoggedUserChannelInfo(channelID: channelID, title: title, userName: userName)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(channelID, forKey: "channelID")
        
        defaults.synchronize()
    }
    
    
    //MARK :
    func hasLogin() -> Bool {
        var defaults: NSUserDefaults? = NSUserDefaults.standardUserDefaults()
        var hasLoggedInFlag: Bool! = defaults?.boolForKey("hasLoggedInKey")
        
        return hasLoggedInFlag
        //        return false
    }
    
    func saveLoggedInFlag() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasLoggedInKey")
        defaults.synchronize()
    }
    
    func authorizeRequest(finishedWithAuth: GTMOAuth2Authentication!) {
        self.auth = finishedWithAuth
        
        self.saveLoggedInFlag()
        
        println("self \(self.auth)")
        var req: NSMutableURLRequest! = NSMutableURLRequest(URL: self.auth.tokenURL)
        self.auth.authorizeRequest(req, completionHandler: {
            (error) -> Void in
            println(self.auth)
        })
    }
}
