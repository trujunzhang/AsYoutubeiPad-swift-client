//
//  YoutubeUserProfile.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeUserProfile: NSObject {
    var isLogin: Bool?
    var auth: GTMOAuth2Authentication!
    let hasLoggedIn: NSString! = "hasLoggedInKey"
    
    
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
        
        if(isLogin == true){
            let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName("Google", clientID: kMyClientID, clientSecret: kMyClientSecret)
            self.authorizeRequest( self.auth )
        }
        

    }
    
    func hasLogin() -> Bool {
        var defaults: NSUserDefaults? = NSUserDefaults.standardUserDefaults()
        var hasLoggedInFlag: Bool! = defaults?.boolForKey(hasLoggedIn)
        
        return hasLoggedInFlag
    }
    
    func saveLoggedInFlag() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: hasLoggedIn)
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
