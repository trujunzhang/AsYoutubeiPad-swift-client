//
//  YTVideoCollectionViewCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Haneke

class YTVideoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var channelContainer: UIView!
    
    @IBOutlet var channelThumbnailImage: UIImageView!
    
    @IBOutlet var channelTitleLabel: UILabel!
    
    
    
    var  videoCache:YoutubeVideoCache?
    
    
    func setupCell(_videoCache:YoutubeVideoCache){
        videoCache = _videoCache
        
        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache!)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        
        // 1
        let url = NSURL(string: thumbnailUrl)
        thumbnailImage.hnk_setImageFromURL(url!)
        
        // 2
        titleLabel.text = videoTitle
        
    }
    
    
    
}
