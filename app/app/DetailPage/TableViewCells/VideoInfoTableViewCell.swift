//
//  VideoInfoTableViewCell.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class VideoInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!


    //    @IBOutlet weak var toggleButton: UIButton!
    
    
    
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
                self.titleLabel.text = videoInfoObject.title
                self.infoLabel.text  = videoInfoObject.likeCount
        
        
        //        self.descriptionLabel.text = videoInfoObject.descriptionString
        //        self.descriptionLabelHeightConstraint.constant = videoInfoObject.currentRowHeight
        //
        //        if(videoInfoObject.isOpen == true){
        //            self.toggleButton.imageView?.image = UIImage(named: "expand_guide")
        //        }else{
        //            self.toggleButton.imageView?.image = UIImage(named: "collapse_guide")
        //        }
        
    }
    
}
