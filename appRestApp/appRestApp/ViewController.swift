//
//  ViewController.swift
//  appRestApp
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit


class ViewController: UIViewController, AuthorUserFetchingDelegate{


    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AuthoredFetcher.sharedInstance.delegate = self
        if (YoutubeUserProfile.sharedInstance.hasLogin() == true) {
            loginButton.enabled = false
            loginButton.backgroundColor = UIColor.redColor()

            //            self.startFetchingLoggedSubscriptionList() // used
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginTapped(sender: AnyObject) {
        let viewController: GTMOAuth2ViewControllerTouch =
        GTMOAuth2ViewControllerTouch(scope: scope, clientID: kMyClientID, clientSecret: kMyClientSecret, keychainItemName: keychainItemName) {
            (controllerTouch, auth, error) -> Void in

            if (error != nil) {
                // Authentication failed

            } else {
                // Authentication succeeded
                YoutubeUserProfile.sharedInstance.authorizeRequest(auth)
                self.startFetchingLoggedSubscriptionList()
                self.dismissViewControllerAnimated(true, completion: {
                    () -> Void in

                })
            }
        }

        let navCon: UINavigationController = UINavigationController(rootViewController: viewController)
        navCon.providesPresentationContextTransitionStyle = true
        navCon.definesPresentationContext = true
        navCon.modalPresentationStyle = .PageSheet

        self.presentViewController(navCon, animated: true) {
            () -> Void in

        }
    }

    func startFetchingLoggedSubscriptionList() {
        AuthoredFetcher.sharedInstance.initLoggedUser()
    }

    // MARK: AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel) {
    }

    func endFetchingUserSubscriptions(array: NSArray) {
    }




}

