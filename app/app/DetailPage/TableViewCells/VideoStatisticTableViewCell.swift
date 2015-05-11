//
//  VideoStatisticTableViewCell.swift
//  app
//
//  Created by djzhang on 5/11/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class VideoStatisticTableViewCell: UITableViewCell {
    
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

}
