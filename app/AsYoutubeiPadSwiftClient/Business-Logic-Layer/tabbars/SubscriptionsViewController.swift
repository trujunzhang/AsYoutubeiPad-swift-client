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
    
    var moviePlayer:MPMoviePlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        playVideo()
    }
    
//     func playVideo()  {
//        
//        let path = NSBundle.mainBundle().pathForResource("example", ofType:"mp4")
//        let url = NSURL.fileURLWithPath(path!)
//        
//        let videoURL = url
//        moviePlayer = MPMoviePlayerViewController(contentURL: videoURL )
//        
//        if let player = moviePlayer {
//            self.view.addSubview(player.view)
//            LayoutUtils.LayoutFullView(player.view!)
//        }
//        else {
//            NSLog("no player")
//        }
//    }
    
    func showMovie(){
        //        let videoURLWithPath = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
        //        let videoURL = NSURL(string: videoURLWithPath)
        
//        let filePathStr:NSString = NSBundle.mainBundle().pathForResource("example", ofType: "mp4")!
//        let videoURL :NSURL = NSURL(fileURLWithPath: filePathStr)!
//        
//        let  asset:AVAsset = AVAsset.assetWithURL(videoURL) as AVAsset
//        let playerItem:AVPlayerItem = AVPlayerItem(asset: asset)
//        
//        let  player:AVPlayer = AVPlayer(playerItem: playerItem)
//        
//        let playerLayer:AVPlayerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.frame
//        self.view.layer.addSublayer(playerLayer)
//        
//        player.play()
        
        
                // Video file
//                let filePathStr:NSString = NSBundle.mainBundle().pathForResource("example", ofType: "mp4")!
//                let fileURL :NSURL = NSURL(fileURLWithPath: filePathStr)!
//        
//                // Subtitles file
//                let subtitlesPathStr :NSString = NSBundle.mainBundle().pathForResource("example", ofType: "srt")!
//        
//                // Create MoviePlayer;
//                let player: MPMoviePlayerController = MPMoviePlayerController()
//                player.contentURL = fileURL
//                player.shouldAutoplay = true
//                player.prepareToPlay()
//        
//                player.view.backgroundColor = UIColor.blueColor()
//        
//                self.view.addSubview(player.view!)
//                LayoutUtils.LayoutFullView(player.view!)
//        
//                player.play()
        
        //        let parser : SOSRTParserHelper = SOSRTParserHelper()
        
        //        player.openSRTFileAtPath(subtitlesPathStr, parserHelper:parser, completion: { (finished) -> Void in
        //
        //            // Activate subtitles
        //            player.showSubtitles()
        //
        //            // add movie player to your view
        //            self.view.addSubview(player.view!)
        //            LayoutUtils.LayoutFullView(player.view!)
        //
        ////             [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:self.player];
        //
        //
        //
        //            player.play()
        //
        //            }) { (error) -> Void in
        //                var x = 0
        //        }
        
        
    }
    
    func showChannelPage(){
        
        //        let channelPageViewController: ChannelPageViewController = ChannelPageViewController() // used
        
        let channelPageViewController: YTVideoWatchViewController = YTVideoWatchViewController()
        channelPageViewController.videoID = "eoXneK3WIgQ"
        
        channelPageViewController.view.frame = container.bounds
        
        container.addSubview(channelPageViewController.view)
        
        self.addChildViewController(channelPageViewController)
    }
    
    func test(){
        
        let button:UIButton = UIButton()
        button.setTitle("wanghao", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.frame = CGRectMake(100, 100, 200, 44)
        
        //        self.view.addSubview(button)
        
        
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
