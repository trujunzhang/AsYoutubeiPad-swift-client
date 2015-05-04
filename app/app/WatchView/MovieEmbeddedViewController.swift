//
//  MovieEmbeddedViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class MovieEmbeddedViewController: UIViewController {

    var videoID = ""
    var dict: [String:IGYouTubeVideo] = [:]

    var group: Cartography.ConstraintGroup?

    var playerView: UIView?

    lazy var normalBarViewController: MovieEmbeddedNormalBarViewController = {
        return MovieEmbeddedNormalBarViewController.instance()
    }()


    // MARK : Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        YoutubeExtractor()

        self.addChildViewController(self.normalBarViewController)
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        LayoutUtils.LayoutFullView(self.view)
        layoutEmbeddedBar()
    }


    func playVideo(videoURL: NSURL) {
        self.normalBarViewController.setVideoURL(videoURL, videoID: videoID)
    }


    func YoutubeExtractor() {
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                self.dict = object as! Dictionary

                // 1
                let gVideo: IGYouTubeVideo = self.dict[YTVideoQualityStringMedium360]!
                let videoURL: NSURL = gVideo.videoURL

                // 2.1
                self.playVideo(videoURL)
            }

        })
    }

    override func viewDidLayoutSubviews() {

    }


    func layoutEmbeddedBar() {
        self.view.addSubview(normalBarViewController.view)
        LayoutUtils.LayoutFullView(normalBarViewController.view)
    }


}