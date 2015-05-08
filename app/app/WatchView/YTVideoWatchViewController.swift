//
//  YTVideoWatchViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideoWatchViewController: UIViewController {
    
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playerViewContainer: UIView!
    @IBOutlet weak var videoInfoContainer: UIView!
    @IBOutlet weak var suggestionContainer: UIView!
    
    var videoID = ""
    
    lazy var movieEmbeddedViewController: MovieEmbeddedViewController = {
        return MovieEmbeddedViewController.instance()
        }()
    
    var videoInfoViewController: VideoInfoViewController = VideoInfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        // initialize all containers
        self.view.addSubview(playerViewContainer)
        self.view.addSubview(videoInfoContainer)
        self.view.addSubview(suggestionContainer)
        
        makeMovieEmbeddedViewController()
        makeVideoInfoViewController()
    }
    
    func makeMovieEmbeddedViewController() {
        movieEmbeddedViewController.videoID = videoID
        
        self.addChildViewController(movieEmbeddedViewController)
        self.playerViewContainer.addSubview(movieEmbeddedViewController.view)
        
    }
    
    func makeVideoInfoViewController() {
        videoInfoViewController.videoID = videoID
        
        self.addChildViewController(videoInfoViewController)
        self.videoInfoContainer.addSubview(videoInfoViewController.view)
    }
    
    override func viewDidLayoutSubviews() {
        func playerViewHeight(width:CGFloat) -> CGFloat {
            return width/16 * 9
        }
        
        let rectWidth = self.view.frame.size.width
        let rectHeight = self.view.frame.size.height
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            let playerWidth = rectWidth/3*2
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  rectWidth - playerWidth
            sideViewHeightConstraint.constant = rectHeight
            infoViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
        } else {
            // portraight
            let playerWidth = rectWidth
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  playerWidth
            sideViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
            infoViewHeightConstraint.constant = 0
        }
    }

    


    
    
}
