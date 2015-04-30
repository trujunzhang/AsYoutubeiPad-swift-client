//
//  RevealViewHelper.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class RevealViewHelper: NSObject {
    var subscriptionsViewController: SubscriptionsViewController?

    class var sharedInstance: RevealViewHelper {

        struct Singleton {
            static let instance = RevealViewHelper()
        }

        return Singleton.instance
    }

    func registerSubscriptionsViewController(subscriptionsViewController: SubscriptionsViewController) {
        self.subscriptionsViewController = subscriptionsViewController
    }

    func changeChannelPanel(channelId: NSString) {
        if let theSubscriptionsViewController: SubscriptionsViewController = self.subscriptionsViewController {
            theSubscriptionsViewController.showChannelPage(channelId)
        }

    }

}