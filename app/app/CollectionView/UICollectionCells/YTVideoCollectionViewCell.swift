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

    func setupCell(_videoCache: YoutubeVideoCache) {
        
//        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        
        videoCache = _videoCache

        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache!)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        let publishedAgo = YoutubeParser.getVideoSnippetChannelPublishedAt(videoCache)

        // 1
        let url = NSURL(string: thumbnailUrl as String)
        let placeHolder = UIImage(named: "thumbnail_border")

        thumbnailImage.sd_setImageWithURL(url, placeholderImage: placeHolder, options: SDWebImageOptions.LowPriority)

        // 2
        titleLabel.text = videoTitle
        infoLabel.text = publishedAgo
        channelTitleLabel.text = channelTitle
    }

}
