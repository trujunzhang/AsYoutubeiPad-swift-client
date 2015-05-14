//
//  SuggestionVideoInfoTableViewCell.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit


class SuggestionVideoInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(videoCache: YoutubeVideoCache){
        let videoTitle = YoutubeParser.getVideoSnippetTitle(videoCache)
        let thumbnailUrl = YoutubeModelParser.getVideoSnippetThumbnails(videoCache)
        let channelTitle = YoutubeParser.getVideoSnippetChannelTitle(videoCache)
        let viewCount = YoutubeParser.getVideoStatisticsViewCount(videoCache)
        let timeAgo = YoutubeParser.getVideoTimeAgoFromPublishedAt(videoCache)
        let totoalTime = YoutubeParser.getVideoDurationForVideoInfo(videoCache)
        
        self.thumbnailImageView.ext_setImageWithNSString(thumbnailUrl)
        
        self.titleLabel.text = videoTitle
        self.contentLabel.text = "\(timeAgo), \(viewCount)"
        
        
    }
}
