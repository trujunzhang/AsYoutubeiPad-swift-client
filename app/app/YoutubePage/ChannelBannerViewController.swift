//
//  ChannelBannerViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class ChannelBannerViewController: UIViewController {
    var channelID: String = ""

    @IBOutlet weak var channelThumbnailImageView: UIImageView!

    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubscribersLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!

    override func viewDidLoad() {
        let defaultImage = UIImage(named: DEFAULT_BANNER_IMAGE_NAME)

    }

}