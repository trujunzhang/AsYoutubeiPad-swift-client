//
//  VideoDescriptionTableViewCell.swift
//  app
//
//  Created by djzhang on 5/11/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class VideoDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: Configure cell
    func configureCell(videoInfoObject: VideoInfoObject){
        self.descriptionLabel.text = videoInfoObject.descriptionString
    }
    
}
