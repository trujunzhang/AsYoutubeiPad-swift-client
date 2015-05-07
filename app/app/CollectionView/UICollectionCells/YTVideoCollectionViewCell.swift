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

    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!

    @IBOutlet var channelTitleLabel: UILabel!

    var imageUrl = ""

    var videoCache: YoutubeVideoCache?

//    var cellLayout: VideoCollectionViewCellLayout = VideoCollectionViewCellLayout()

    func setupCell(_videoCache: YoutubeVideoCache) {

//        cellLayout.layoutVideoThumbnailImageContainer(thumbnailImage, totalTimeLabel: totalTimeLabel)
//        VideoCollectionViewCellLayout.layoutVideoInfoContainer(infoContainer)
//        VideoCollectionViewCellLayout.layoutVideoTitleLabelAndInfoLabel(titleLabel, infoLabel: infoLabel)
//        VideoCollectionViewCellLayout.layoutVideoChanelContainer(channelThumbnailImage, channelTitleLabel: channelTitleLabel)

        videoCache = _videoCache

        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache!)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        let publishedAgo = YoutubeParser.getVideoSnippetChannelPublishedAt(videoCache)

        // 1
        let url = NSURL(string: thumbnailUrl as String)
        //        thumbnailImage.hnk_setImageFromURL(url!) // used

        let placeHolder = UIImage(named: "thumbnail_border")

        //        thumbnailImage.sd_setImageWithURL(url,placeHolder:placeHolder,options: SDWebImageDownloaderOptions.LowPriority)

        //        thumbnailImage.sd_setImageWithURL(url)


        thumbnailImage.sd_setImageWithURL(url, placeholderImage: placeHolder, options: SDWebImageOptions.LowPriority)

        //        self.thumbnailImage.hnk_setImageFromURL(NSURL(string: self.imageUrl)!)// used

        // 2
        titleLabel.text = videoTitle

        // 3
        infoLabel.text = publishedAgo

        // 4
        channelTitleLabel.text = channelTitle

    }

}
