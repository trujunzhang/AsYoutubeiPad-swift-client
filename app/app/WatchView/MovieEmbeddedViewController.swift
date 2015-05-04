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

    var videoID: String = "" {
        didSet {
            YoutubeExtractor()
        }
    }
    var dict: [String:IGYouTubeVideo] = [:]

    var group: Cartography.ConstraintGroup?

    var playerView: UIView?

    lazy var normalBarViewController: MovieEmbeddedNormalBarViewController = {
        return MovieEmbeddedNormalBarViewController.instance()
    }()


    // MARK : Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewController(self.normalBarViewController)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        LayoutUtils.LayoutFullView(self.view)
        self.view.addSubview(normalBarViewController.view)
        LayoutUtils.LayoutFullView(normalBarViewController.view)
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


    func playVideo(videoURL: NSURL) {
        self.normalBarViewController.setVideoURL(videoURL, videoID: videoID)
    }


}