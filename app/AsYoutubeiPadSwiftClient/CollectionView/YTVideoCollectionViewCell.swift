//
//  YTVideoCollectionViewCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class YTVideoCollectionViewCell: UICollectionViewCell {
    var youTubeVideo:GTLYouTubeVideo?
    
    init(_youTubeVideo:GTLYouTubeVideo) {
        super.init()
        
        youTubeVideo = _youTubeVideo
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
