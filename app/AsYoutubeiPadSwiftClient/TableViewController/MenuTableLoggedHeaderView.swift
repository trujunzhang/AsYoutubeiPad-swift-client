//
//  MenuTableLoggedHeaderView.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class MenuTableLoggedHeaderView: UIViewController {
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var eventButton: UIImageView!
    
    var _nodeCellSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _nodeCellSize = CGSizeMake(REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
        
        self.setupView()
                        
        self.view.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
    }
    
    
    override func viewDidLayoutSubviews() {
        self.layoutUserProfileUI()
    }
    
    func setupView() {
        //        let userChannel: GTLYouTubeChannel = YoutubeUserProfile.sharedInstance.userChannel!
        
        nickNameLabel.textColor = UIColor.whiteColor()
        userNameLabel.textColor = UIColor.whiteColor()
        
        nickNameLabel.text = "Trujun Zhang"
        userNameLabel.text = "wanghaobackup@gmail.com"
    }
    
    func layoutUserProfileUI() {
        
        
        var nickName = nickNameLabel
        var userName = userNameLabel
        
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        
        var thumbnailRect:CGRect = thumbnailImageView.frame
        var eventButtonX:CGFloat = eventButton.frame.origin.x
        
        var thumbnailRightX = thumbnailRect.origin.x + thumbnailRect.size.width
        
        let rightWidth = width! - eventButtonX + ICON_PADDING_RIGHT
        var verticalSecondX = thumbnailRightX + ICON_PADDING_RIGHT
        var vWidth:CGFloat = width! - verticalSecondX - rightWidth
        
        
        var middleY = height! / 2
        var nodeHeight: CGFloat?
        
        //1
        var vLeft: CGFloat = LEFT_MIDDLE_X - USER_ICON_WH / 2
        var vTop: CGFloat = (height! - USER_ICON_WH) / 2
        
        
        //3
        nodeHeight = 20
        vTop = middleY - nodeHeight!
        nickName.frame = CGRectMake(verticalSecondX, vTop, vWidth, nodeHeight!)
        
        //4
        nodeHeight = 18
        vTop = middleY
        userName.frame = CGRectMake(verticalSecondX, vTop + 2, vWidth, nodeHeight!)
        
//        userName.backgroundColor = UIColor.redColor()
    }
    
}