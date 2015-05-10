//
//  VideoInfoTableViewCell.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class VideoInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var topPanel: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UIButton!
    
    @IBOutlet weak var disLikeCountLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(videoInfoObject: VideoInfoObject){
        
    }

}
