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
    var revealViewController: SWRevealViewController?

    class var sharedInstance: RevealViewHelper {

        struct Singleton {
            static let instance = RevealViewHelper()
        }

        return Singleton.instance
    }

    func registerSubscriptionsViewController(subscriptionsViewController: SubscriptionsViewController) {
        self.subscriptionsViewController = subscriptionsViewController
    }

    func registerSWRevealViewController(revealViewController: SWRevealViewController) {
        self.revealViewController = revealViewController
    }

    // MARK: SWRevealViewController
    func openLeftMenu() {
        if let theRevealViewController: SWRevealViewController = self.revealViewController {
            theRevealViewController.setFrontViewPosition(.Right, animated: true)
        }
    }

    func closeLeftMenu() {
        if let theRevealViewController: SWRevealViewController = self.revealViewController {
            theRevealViewController.setFrontViewPosition(.LeftSide, animated: true)

        }
    }

    func changeChannelPanel(channelId: NSString) {
        if let theSubscriptionsViewController: SubscriptionsViewController = self.subscriptionsViewController {
            closeLeftMenu()
            theSubscriptionsViewController.showChannelPage(channelId)
        }

    }

}