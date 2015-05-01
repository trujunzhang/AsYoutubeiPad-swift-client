//
//  YTVideoCollectionViewCell.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Foundation

class NBVideoCollectionViewCellObject: NSObject, NICollectionViewNibCellObject {
    var videoCache: YoutubeVideoCache?
    init(videoCache: YoutubeVideoCache) {
        self.videoCache = videoCache
    }

    // MARK: NICollectionViewNibCellObject
    func collectionViewCellNib() -> UINib {
        return UINib(nibName: "NBVideoCollectionViewCell", bundle: nil)
    }
}

class NBVideoCollectionViewCell: UICollectionViewCell, NICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var channelContainer: UIView!
    @IBOutlet var channelThumbnailImage: UIImageView!
    @IBOutlet var channelTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: NICollectionViewCell
    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        let cellObject = object as! NBVideoCollectionViewCellObject
        let videoCache: YoutubeVideoCache = cellObject.videoCache!

        setupCell(videoCache)

        return true
    }


    func setupCell(videoCache: YoutubeVideoCache) {

        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        let publishedAgo = YoutubeParser.getVideoSnippetChannelPublishedAt(videoCache)

        // 1
        let url = NSURL(string: thumbnailUrl as String)
        thumbnailImage.hnk_setImageFromURL(url!) // used

        // 2
        titleLabel.text = videoTitle

        // 3
        infoLabel.text = publishedAgo

        // 4
        channelTitleLabel.text = channelTitle

        // 5
        setupChannelThumbnail(videoCache)
    }

    func setupChannelThumbnail(videoCache: YoutubeVideoCache) {
        let channelID = YoutubeParser.getChannelIdByVideo(videoCache)

        YoutubeFetcher.sharedInstance.fetchChannelForThumbnail(channelID, completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray

                var channel: MABYT3_Channel = array[0] as! MABYT3_Channel
                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)

                let url = NSURL(string: imageUrl as String)
                self.channelThumbnailImage.hnk_setImageFromURL(url!)// used
            }
        })

    }


}
