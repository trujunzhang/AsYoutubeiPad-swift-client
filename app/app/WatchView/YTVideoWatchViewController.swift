//
//  YTVideoWatchViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class YTVideoWatchViewController: UIViewController {

    var videoID = ""
    var group: Cartography.ConstraintGroup = Cartography.ConstraintGroup()

    // MARK : All containers
    lazy var moviePlayContainer: UIView = {
        var container = UIView()
        container.backgroundColor = UIColor.redColor()
        return container
    }()
    lazy var videoInfoContainer: UIView = {
        var container = UIView()
        container.backgroundColor = UIColor.greenColor()
        return container
    }()
    lazy var videoOtherContainer: UIView = {
        var container = UIView()
        container.backgroundColor = UIColor.blueColor()
        return container
    }()


    lazy var movieEmbeddedViewController: MovieEmbeddedViewController = {
        return MovieEmbeddedViewController.instance()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None

        // initialize all containers
        self.view.addSubview(moviePlayContainer)
        self.view.addSubview(videoInfoContainer)
        self.view.addSubview(videoOtherContainer)

        makeMovieEmbeddedViewController()
    }

    func makeMovieEmbeddedViewController() {
        movieEmbeddedViewController.videoID = videoID

        self.moviePlayContainer.addSubview(movieEmbeddedViewController.view)
        self.addChildViewController(movieEmbeddedViewController)
    }

    override func viewDidLayoutSubviews() {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            setupViewHorizontalLayout()
        } else {
            // portraight
            setupViewVerticalLayout()
        }
    }

    func setupViewVerticalLayout() {

        group = constrain(moviePlayContainer, videoInfoContainer, videoOtherContainer, replace: group) {
            view1, view2, view3 in
            // _moviePlayContainer
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            view1.top == view1.superview!.top

            view1.height == (view1.width * 324) / 576

            // _videoInfoContainer
            view2.leading == view2.superview!.leading
            view2.trailing == view2.superview!.trailing

            view2.top == view1.bottom
            view2.height == 0

            // _videoOtherContainer
            view3.leading == view3.superview!.leading
            view3.trailing == view3.superview!.trailing

            view3.top == view1.bottom
            view3.bottom == view3.superview!.bottom
        }
    }

    func setupViewHorizontalLayout() {

        group = constrain(moviePlayContainer, videoInfoContainer, videoOtherContainer, replace: group) {
            view1, view2, view3 in
            // _moviePlayContainer
            view1.leading == view1.superview!.leading
            view1.top == view1.superview!.top

            view1.width == (view1.superview!.width / 3) * 2
            view1.height == (view1.width * 324) / 576

            // _videoInfoContainer
            view2.leading == view2.superview!.leading
            view2.bottom == view2.superview!.bottom

            view2.top == view1.bottom
            view2.width == view1.width

            // _videoOtherContainer
            view3.top == view3.superview!.top
            view3.trailing == view2.superview!.trailing
            view3.bottom == view3.superview!.bottom

            view3.leading == view1.trailing
        }
    }


}
