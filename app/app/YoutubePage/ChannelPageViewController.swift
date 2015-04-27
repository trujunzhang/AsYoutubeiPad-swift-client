//
//  ChannelPageViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class ChannelPageViewController: UIViewController {

    var channelBannerViewController: ChannelBannerViewController?
    var channelBannerView: UIView?;

    var tabBarController: YTTabBarController?
    var tabBarView: UIView?


    override func viewDidLoad() {
        // 1. Top channel Banner panel
        channelBannerViewController = ChannelBannerViewController.instance()

        channelBannerView = channelBannerViewController.view
        if let theChannelBannerView: UIView = channelBannerView {
            self.view.addSubview(theChannelBannerView)
        }

        // 2.
        tabBarController = YTTabBarController()
        self.addChildViewController(tabBarController)

        tabBarView = tabBarController.view
        tabBarView?.backgroundColor = UIColor.blueColor()
        if let theTabBarView: UIView = tabBarView {
            self.view.addSubview(theTabBarView)
        }

        //3.
        if let theChannelBannerView: UIView = channelBannerView, theTabBarView: UIView = tabBarView {
            layout(theChannelBannerView, theTabBarView) {
                view1, view2 in

                view1.centerX == view1.superview!.centerX
                view2.centerX == view1.centerX

                view1.width == view1.superview!.width
                view2.width == view1.width

                view1.height == 200

                view1.top == view1.superview!.top
                view2.top == view1.bottom

                view2.bottom == view2.superview!.bottom
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        var x = 0
    }


}