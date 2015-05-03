//
//  YTVideoCollectionViewCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

//import Haneke

import WebImage

class YTVideoCollectionViewCell: UICollectionViewCell {


    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var channelContainer: UIView!
    @IBOutlet var channelThumbnailImage: UIImageView!
    @IBOutlet var channelTitleLabel: UILabel!

    var imageUrl = ""

    var videoCache: YoutubeVideoCache?


    func setupCell(_videoCache: YoutubeVideoCache) {
        videoCache = _videoCache

        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache!)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        let publishedAgo = YoutubeParser.getVideoSnippetChannelPublishedAt(videoCache)

        // 1
        let url = NSURL(string: thumbnailUrl as String)
//        thumbnailImage.hnk_setImageFromURL(url!) // used

        let placeHolder = UIImage(named: "Travel")

//        thumbnailImage.sd_setImageWithURL(url,placeHolder:placeHolder,options: SDWebImageDownloaderOptions.LowPriority)

//        self.thumbnailImage.hnk_setImageFromURL(NSURL(string: self.imageUrl)!)// used

        // 2
        titleLabel.text = videoTitle

        // 3
        infoLabel.text = publishedAgo

        // 4
        channelTitleLabel.text = channelTitle

        // 5
//        setupChannelThumbnail()
    }

    func setupChannelThumbnail() {
        let channelID = YoutubeParser.getChannelIdByVideo(videoCache)

        if (self.imageUrl.isEmpty) {
            self.fetchChannelThumbnail(channelID)
        } else {
            self.channelThumbnailImage.sd_setImageWithURL(NSURL(string: self.imageUrl)!)
//            self.channelThumbnailImage.hnk_setImageFromURL(NSURL(string: self.imageUrl)!)// used
        }

    }

    func fetchChannelThumbnail(channelID: NSString) {
        YoutubeFetcher.fetchChannelForThumbnail(channelID, completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray

                var channel: MABYT3_Channel = array[0] as! MABYT3_Channel
                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)

                self.imageUrl = imageUrl as String

                self.channelThumbnailImage.sd_setImageWithURL(NSURL(string: self.imageUrl)!)
//                self.channelThumbnailImage.hnk_setImageFromURL(NSURL(string: self.imageUrl)!)// used
            }
        })
    }


}
