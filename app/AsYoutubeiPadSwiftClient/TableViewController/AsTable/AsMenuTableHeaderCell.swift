//
//  AsMenuTableRowCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class AsMenuTableHeaderCell: ASCellNode {
    
    var _nodeCellSize: CGSize?
    var _parent: UIViewController?
    var _delegate: ASTableCellProtocols?
    
    let PADINGTOP: CGFloat = 20
    
    var asNodeDictionary = [String: ASDisplayNode]()
    
    
    init(nodeCellSize: CGSize, parent: UIViewController, delegate: ASTableCellProtocols) {
        super.init()
        
        selectionStyle = UITableViewCellSelectionStyle.None;
        _parent = parent
        _nodeCellSize = nodeCellSize
        _delegate = delegate
        
        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
            self.makeUserProfileUI()
        } else {
            self.makeLoginUI()
        }
        
        for node in asNodeDictionary.values {
            self.addSubnode(node as! ASDisplayNode)
        }
        
        // 3
        self.backgroundColor = UIColor.clearColor()
        //        self.backgroundColor = UIColor.redColor()
    }
    
    // MARK: Make different panel by login status
    func makeLoginUI() {
        // 1
        let _videoChannelThumbnailsNode = ASImageNode()
        _videoChannelThumbnailsNode?.image = UIImage(named: "signin")
        _videoChannelThumbnailsNode?.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        asNodeDictionary["icon"] = _videoChannelThumbnailsNode!
        
        // 2
        let _channelTitleTextNode = AsNodeMaker.makeNodeText()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        _channelTitleTextNode.attributedString = NSAttributedString(string: "Sign In", attributes: textFontAttributes)
        
        asNodeDictionary["title"] = _channelTitleTextNode
    }
    
    func makeUserProfileUI() {
        // 1: left
        let userThumbnail = ASImageNode()
        userThumbnail?.image = UIImage(named: "account_default_thumbnail")
        asNodeDictionary["userThumbnail"] = userThumbnail!
        
        // 2: right
        let signoutIcon = ASImageNode()
        signoutIcon?.image = UIImage(named: "signout")
        signoutIcon?.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        asNodeDictionary["signoutIcon"] = signoutIcon!
        
        // 3: top
        let nickName =  AsNodeMaker.makeNodeText()
        
        var textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        var textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        nickName.attributedString = NSAttributedString(string: "Zhang Trujun", attributes: textFontAttributes)
        
        asNodeDictionary["nickName"] = nickName
        
        // 3: bottom
        let userName = AsNodeMaker.makeNodeText()
        
        textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.grayColor(), NSParagraphStyleAttributeName: textStyle]
        userName.attributedString = NSAttributedString(string: "wanghaobackup@gmail.com", attributes: textFontAttributes)
        
        asNodeDictionary["userName"] = userName
    }
    
    
    func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        return _nodeCellSize!
    }
    
    func layout() {
        
        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
            self.layoutUserProfileUI()
        } else {
            self.layoutLoginUI()
        }
    }
    
    func layoutUserProfileUI() {
        
        var userThumbnail = asNodeDictionary["userThumbnail"] as! ASImageNode
        var signoutIcon = asNodeDictionary["signoutIcon"] as! ASImageNode
        var nickName = asNodeDictionary["nickName"] as! ASTextNode
        var userName = asNodeDictionary["userName"] as! ASTextNode
        
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        
        height = height! - PADINGTOP // padding top
        
        var middleY = height! / 2
        var nodeSize:CGSize?
        var nodeHeight:CGFloat?
        
        //1
        var vLeft:CGFloat = LEFT_MIDDLE_X - USER_ICON_WH / 2
        var vTop :CGFloat = (height! - USER_ICON_WH) / 2
        userThumbnail.frame = CGRectMake(vLeft, vTop + PADINGTOP, USER_ICON_WH, USER_ICON_WH)
        
        //3
        var verticalSecondX = vLeft + USER_ICON_WH + ICON_PADDING_RIGHT
        var vWidth = width! - verticalSecondX - LOGIN_OUT_ICON_PADDING_RIGHT - LOGIN_ICON_WH - ICON_PADDING_RIGHT
        
        nodeSize = nickName.measure(_nodeCellSize!)
        nodeHeight = nodeSize?.height
        vTop = middleY - nodeHeight!
        nickName.frame = CGRectMake(verticalSecondX, vTop + PADINGTOP, vWidth, nodeHeight!)
        
        //4
        nodeSize = userName.measure(_nodeCellSize!)
        nodeHeight = nodeSize?.height
        vTop = middleY
        userName.frame = CGRectMake(verticalSecondX, vTop + 2 + PADINGTOP, vWidth, nodeHeight!)
        
        //2
        vLeft = width! - LOGIN_OUT_ICON_PADDING_RIGHT - LOGIN_ICON_WH
        vTop = (height! - LOGIN_ICON_WH) / 2
        signoutIcon.frame = CGRectMake(vLeft, vTop + PADINGTOP, LOGIN_ICON_WH, LOGIN_ICON_WH)
    }
    
    func layoutLoginUI() {
        let _videoChannelThumbnailsNode = asNodeDictionary["icon"] as! ASImageNode
        let _channelTitleTextNode = asNodeDictionary["title"] as! ASTextNode
        
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        
        height = height! - PADINGTOP // padding top
        
        //1
        var vTop = (height! - LOGIN_ICON_WH) / 2
        _videoChannelThumbnailsNode.frame = CGRectMake(ICON_PADDING_LEFT, vTop + PADINGTOP, LOGIN_ICON_WH, LOGIN_ICON_WH)
        
        //2
        var vLeft = ICON_PADDING_LEFT + LOGIN_ICON_WH + ICON_PADDING_RIGHT
        vTop = (height! - TITLE_FONT_SIZE) / 2 - 3
        var vWidth = width! - vLeft
        
        _channelTitleTextNode.frame = CGRectMake(vLeft, vTop + PADINGTOP, vWidth, height! - vTop)
        
    }
    
    // MARK: Button tapped events
    func buttonTapped(sender: idtype_t) {
        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
            //        if(_delegate != nil){
            //            _delegate?.updateForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), rowType: .LeftTableRowType_Header)
            //        }
        } else {
            self.startLogIn()
        }
        
        
    }
    
    func startLogIn() {
        
        var gvc: GTMOAuth2ViewControllerTouch! = GTMOAuth2ViewControllerTouch(scope: scope, clientID: kMyClientID, clientSecret: kMyClientSecret, keychainItemName: "Google", delegate: self, finishedSelector: "viewController:finishedWithAuth:error:")
        
        var navController:UINavigationController = UINavigationController(rootViewController: gvc)
        
        let controller: UIViewController = UIApplication.sharedApplication().keyWindow!.rootViewController!
        
        controller.modalPresentationStyle = UIModalPresentationStyle.None
        controller.presentViewController(navController, animated: true, completion: nil)
    }
    
    
    func viewController(viewController: GTMOAuth2ViewControllerTouch!, finishedWithAuth: GTMOAuth2Authentication!, error: NSError?) {
        if (error != nil) {
        } else {
            YoutubeUserProfile.sharedInstance.authorizeRequest(finishedWithAuth)
        }
        
        let controller: UIViewController = UIApplication.sharedApplication().keyWindow!.rootViewController!
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
