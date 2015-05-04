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

    // MARK : All containers
    var videoInfoContainer: UIView?
    var videoOtherContainer: UIView?

    lazy var moviePlayContainer: UIView = {
        var container = UIView()
        container.backgroundColor = UIColor.redColor()
        return container
    }()

    var group: Cartography.ConstraintGroup = Cartography.ConstraintGroup()

    var videoID = ""


    var movieEmbeddedViewController: MovieEmbeddedViewController?
    var movieEmbeddedView: UIView?


    override func viewDidLoad() {
        // initialize all containers
        makeAllContainers()

        makeMovieEmbeddedViewController()
    }

    func makeMovieEmbeddedViewController() {
        movieEmbeddedViewController = MovieEmbeddedViewController.instance()
        movieEmbeddedViewController?.videoID = videoID

        movieEmbeddedView = movieEmbeddedViewController?.view
        movieEmbeddedView?.backgroundColor = UIColor.yellowColor() // test

        if let view: UIView = movieEmbeddedView {
            self.moviePlayContainer.addSubview(view)
        }

        if let controller: UIViewController = movieEmbeddedViewController {
            self.addChildViewController(controller)
        }
    }

    func makeAllContainers() {
        self.view.addSubview(moviePlayContainer)

        videoInfoContainer = UIView()
        videoInfoContainer?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(videoInfoContainer!)

        videoOtherContainer = UIView()
        videoOtherContainer?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(videoOtherContainer!)
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

        group = constrain(moviePlayContainer, videoInfoContainer!, videoOtherContainer!, replace: group) {
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

        group = constrain(moviePlayContainer, videoInfoContainer!, videoOtherContainer!, replace: group) {
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
