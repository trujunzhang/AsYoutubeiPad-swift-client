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
        prepareFetchChannelInfo()

    }

    func prepareFetchChannelInfo() {
        let defaultImage = UIImage(named: DEFAULT_BANNER_IMAGE_NAME)
        self.channelThumbnailImageView.image = defaultImage

        self.channelTitleLabel.text = ""
        self.channelSubscribersLabel.text = ""
        self.subscribeButton.hidden = true
    }

    // MARK: update view
    func updatePanel(channel: MABYT3_Channel) {
        let imageUrl: String = YoutubeParser.getChannelBannerImageUrlArray(channel)
        let title = YoutubeParser.getChannelBrandingSettingsTitle(channel)
        let subscriptonCount = YoutubeParser.getChannelStatisticsSubscriberCount(channel)

        if(imageUrl.isEmpty == false){
            self.channelThumbnailImageView.hnk_setImageFromURL(NSURL(string: imageUrl)!)
        }
        self.channelTitleLabel.text = title
        self.channelSubscribersLabel.text = subscriptonCount
    }

}