//
//  YTTabBarItemsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let TABLE_TITLE_ACTIVITY : String = "Activity"
let TABLE_TITLE_VIDEOS: String = "Videos"
let TABLE_TITLE_PLAYLIST: String = "PlayList"

struct TabBarItemsDictionary {
    var buttons: [String:UIButton] = [String:UIButton]()
    var viewControllers:[String:UIViewController] = [String:UIViewController]()
}


class YTTabBarItemsViewController: UIViewController {

    @IBOutlet var buttonGroupPanel: UIView!
    @IBOutlet var activityButton: UIButton!
    @IBOutlet var videosButton: UIButton!
    @IBOutlet var playListButton: UIButton!
    @IBOutlet var separator1: UIImageView!
    @IBOutlet var separator2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()
    }

    func makeTabBarItemsDictionary() -> TabBarItemsDictionary {
        let controller: UIViewController? = UIViewController()
        let collectionView: YTVideosCollectionViewController = YTVideosCollectionViewController.instance()

        //1
        var buttons: [String:UIButton] = [String:UIButton]()
        buttons[TABLE_TITLE_ACTIVITY] = activityButton!
        buttons[TABLE_TITLE_VIDEOS] = videosButton!
        buttons[TABLE_TITLE_PLAYLIST] = playListButton!

        //2
        var viewControllers: [String:UIViewController] = [String:UIViewController]()
        viewControllers[TABLE_TITLE_ACTIVITY] = collectionView
        viewControllers[TABLE_TITLE_VIDEOS] = controller!
        viewControllers[TABLE_TITLE_PLAYLIST] = controller!

        return TabBarItemsDictionary(buttons: buttons, viewControllers: viewControllers)
    }


}