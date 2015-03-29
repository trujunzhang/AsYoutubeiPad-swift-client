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
        
        self.layoutUserProfileUI()
        
        self.view.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }
    
    func setupView() {
        
        //        let userChannel: GTLYouTubeChannel = YoutubeUserProfile.sharedInstance.userChannel!
        
        userNameLabel.text = "wanghao"
        
    }
    
    func layoutUserProfileUI() {
        
        var nickName = nickNameLabel
        var userName = userNameLabel
        
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        
        
        var middleY = height! / 2
        var nodeSize: CGSize?
        var nodeHeight: CGFloat?
        
        //1
        var vLeft: CGFloat = LEFT_MIDDLE_X - USER_ICON_WH / 2
        var vTop: CGFloat = (height! - USER_ICON_WH) / 2
        
        
        var verticalSecondX = vLeft + USER_ICON_WH + ICON_PADDING_RIGHT
        var vWidth = width! - verticalSecondX - LOGIN_OUT_ICON_PADDING_RIGHT - LOGIN_ICON_WH - ICON_PADDING_RIGHT
        
        //3
        nodeHeight = 20
        vTop = middleY - nodeHeight!
        nickName.frame = CGRectMake(verticalSecondX, vTop, vWidth, nodeHeight!)
        
        //4
        nodeHeight = 18
        vTop = middleY
        userName.frame = CGRectMake(verticalSecondX, vTop + 2, vWidth, nodeHeight!)
        
    }
    
}