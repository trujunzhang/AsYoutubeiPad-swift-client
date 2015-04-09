//
//  SubscriptionsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import AVFoundation


class SubscriptionsViewController: FrontBaseViewController {
    
    @IBOutlet var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showChannelPage()
        
        //        self.showMovie()
        
    }
    
    
    func showMovie(){
        //        let videoURLWithPath = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        //        let videoURL = NSURL(string: videoURLWithPath)
        
        let filePathStr:NSString = NSBundle.mainBundle().pathForResource("example", ofType: "mp4")!
        let videoURL :NSURL = NSURL(fileURLWithPath: filePathStr)!
        
        let  asset:AVAsset = AVAsset.assetWithURL(videoURL) as AVAsset
        let playerItem:AVPlayerItem = AVPlayerItem(asset: asset)
        
        let  player:AVPlayer = AVPlayer(playerItem: playerItem)
        
        let playerLayer:AVPlayerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        self.view.layer.addSublayer(playerLayer)
        
        player.play()
        
        //player.currentTime()
    }
    
    func showChannelPage(){
        
        //        let channelPageViewController: ChannelPageViewController = ChannelPageViewController() // used
        
        let channelPageViewController: YTVideoWatchViewController = YTVideoWatchViewController()
        channelPageViewController.videoID = "uD6Okha_Yj0"
        
        channelPageViewController.view.frame = container.bounds
        
        container.addSubview(channelPageViewController.view)
        
        self.addChildViewController(channelPageViewController)
    }
    
    func test(){
        
        
        
        var tabBarItemsController: UIViewController =
        self.storyboard!.instantiateViewControllerWithIdentifier("YTTabBarItemsViewController") as UIViewController
        
        
        let headerView:UIView = UIView()
        headerView.frame = CGRectMake(0, 100, self.view.frame.size.width, 44)
        headerView.addSubview(tabBarItemsController.view)
        
        
        //        self.view.addSubview(headerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
