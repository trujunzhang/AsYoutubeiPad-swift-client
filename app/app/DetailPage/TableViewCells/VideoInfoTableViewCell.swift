//
//  VideoInfoTableViewCell.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class VideoInfoTableViewCell: UITableViewCell {
    var videoInfoObject: VideoInfoObject?

    @IBOutlet weak var topPanel: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UIButton!
    
    @IBOutlet weak var disLikeCountLabel: UIButton!
    
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.createTapGestureRecognizerForView(topPanel)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: tapped event
    func createTapGestureRecognizerForView(view: UIView) {
        let playTap = UITapGestureRecognizer(target: self, action: "playTapped")
        playTap.numberOfTouchesRequired = 1
        playTap.numberOfTapsRequired = 1
        view.userInteractionEnabled = true
        view.addGestureRecognizer(playTap)
    }
    
    // MARK: UITapGestureRecognizer
    func playTapped() {
        if let infoObject: VideoInfoObject = videoInfoObject {
             if let theVideoInfoToggleProtocol: VideoInfoToggleProtocol = infoObject.videoInfoToggleProtocol {
                theVideoInfoToggleProtocol.toggleVideoInfoPanel({
                    (object, isOpen) -> Void in
                    
                })
            }
        }
    }
    
    // MARK: Configure cell
    func configureCell(videoInfoObject: VideoInfoObject){
        self.videoInfoObject = videoInfoObject
        
        self.titleLabel.text = videoInfoObject.title
        self.infoLabel.text  = videoInfoObject.likeCount
        
        self.descriptionLabel.text = videoInfoObject.descriptionString
        self.descriptionLabelHeightConstraint.constant = videoInfoObject.maxHeightValue
        
        if(videoInfoObject.isOpen == true){
            self.toggleButton.imageView?.image = UIImage(named: "expand_guide")
        }else{
            self.toggleButton.imageView?.image = UIImage(named: "collapse_guide")
        }
        
    }

}
