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
        let rectWidth = self.view.frame.size.width
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            playerViewWidthConstraint.constant = rectWidth/3*2
        } else {
            // portraight
            playerViewWidthConstraint.constant = rectWidth
        }
    }
    


    
    
}
