//
//  ChannelInfoTableViewCell.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class ChannelInfoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(videoInfoObject: VideoInfoObject){
        let width =  self.frame.size.width
        println("width is \(width)")
        //        self.titleLabel.text = videoInfoObject.title
        //        self.infoLabel.text  = videoInfoObject.likeCount
    }

}
