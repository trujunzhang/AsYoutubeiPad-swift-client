//
//  YTVideoCollectionViewCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class YTVideoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    var  videoCache:YoutubeVideoCache?
    
    
    func setupCell(_videoCache:YoutubeVideoCache){
        videoCache = _videoCache
        
        let title = YoutubeParser.getVideoSnippetTitle(videoCache)
        
        titleLabel.text = title
    }
    
    
    
}
