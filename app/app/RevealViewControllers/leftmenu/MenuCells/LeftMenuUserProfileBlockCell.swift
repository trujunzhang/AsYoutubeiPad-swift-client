//
//  LeftMenuDrawRectBlockCell.swift
//  app
//
//  Created by djzhang on 4/22/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Cartography

class LeftMenuUserProfileBlockCell: NIDrawRectBlockCell {
    var videoInfoObject: VideoInfoObject?
    
    var descriptionLabel: NIAttributedLabel?
    var titleLabel: UILabel?
    var likeCountLabel: UILabel?
    var toggleButton: UIImageView?
    
    var toggleContainer: UIView?
    
    var group: Cartography.ConstraintGroup?
    
    var _font: UIFont?
    
    var isShowed = false
    
    // MARK : static functions
    class func getDescriptionBlockCellFont() -> UIFont {
        return UIFont(name: "AmericanTypewriter", size: 12)!
    }
    
    class func getBlockCellHeight(object: VideoInfoObject, width: CGFloat) -> CGFloat {
        let boundingRect = object.descriptionString.boundingRectWithSize(CGSizeMake(width, CGFloat.max),
            options: .UsesLineFragmentOrigin | .UsesFontLeading,
            attributes: [NSFontAttributeName: VideoInfoDrawRectBlockCell.getDescriptionBlockCellFont()],
            context: nil)
        
        let cellHeight = boundingRect.size.height + 120
        return cellHeight
    }
    
    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // line01
        toggleContainer = UIView()
        titleLabel = UILabel()
        likeCountLabel = UILabel()
        makeButton()
        if let _toggleContainer: UIView = toggleContainer, _titleLabel: UILabel = titleLabel, _likeCountLabel: UILabel = likeCountLabel, _toggleButton: UIImageView = toggleButton {
            
            let playTap = UITapGestureRecognizer(target: self, action: "playTapped")
            playTap.numberOfTouchesRequired = 1
            playTap.numberOfTapsRequired = 1
            _toggleContainer.userInteractionEnabled = true
            _toggleContainer.addGestureRecognizer(playTap)
            
            self.blockView.addSubview(_toggleContainer)
            
            _toggleContainer.addSubview(_titleLabel)
            _toggleContainer.addSubview(_likeCountLabel)
            _toggleContainer.addSubview(_toggleButton)
            
            layout(_toggleContainer) {
                view1 in
                
                // _titleLabel
                view1.leading == view1.superview!.leading
                view1.trailing == view1.superview!.trailing
                
                view1.top == view1.superview!.top
                view1.height == VIDEO_INFO_TITLE_PANEL_HEIGHT
            }
            
        }
        
        // line02
        descriptionLabel = NIAttributedLabel()
        if let _descriptionLabel: NIAttributedLabel = descriptionLabel {
            makeDescriptionLabel(_descriptionLabel)
            self.blockView.addSubview(_descriptionLabel)
        }
        
        LayoutTitlePanel()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        
    }
    
    override func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        super.shouldUpdateCellWithObject(object)
        
        //        if (isShowed == true) {
        //            return false
        //        }
        
        let infoObject: VideoInfoObject = object.object as! VideoInfoObject
        
        if let infoObject: VideoInfoObject = videoInfoObject {
        } else {
            //            println("VideoInfoToggleProtocol  ... ")
            videoInfoObject = infoObject
        }
        
        showToggleImage(infoObject.isOpen)
        
        if let _descriptionLabel: NIAttributedLabel = descriptionLabel, _titleLabel: UILabel = titleLabel, _likeCountLabel: UILabel = likeCountLabel {
            _descriptionLabel.text = infoObject.descriptionString
            _titleLabel.text = infoObject.title
            _likeCountLabel.text = infoObject.likeCount
            
            //            let rect: CGRect = CGRectMake(VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT, VIDEO_INFO_TITLE_PANEL_HEIGHT,
            //                infoObject.descriptionWidth - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT * 2, maxHeight)
            _descriptionLabel.frame = infoObject.descriptionRect!
            
            println("shouldUpdateCellWithObject... +\(infoObject.descriptionRect)")
            
            isShowed = true
        }
        
        return true
    }
    
    func makeDescriptionLabel(label: NIAttributedLabel) {
        label.numberOfLines = 0
        //        label.lineBreakMode = NSLineBreakByWordWrapping
        label.font = VideoInfoDrawRectBlockCell.getDescriptionBlockCellFont()
        
        // When the user taps a link we can change the way the link text looks.
        label.attributesForHighlightedLink = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        // In order to handle the events generated by the user tapping a link we must implement the
        // delegate.
        //    label.delegate = self;
        
        // By default the label will not automatically detect links. Turning this on will cause the label
        // to pass through the text with an NSDataDetector, highlighting any detected URLs.
        label.autoDetectLinks = true
        
        // By default links do not have underlines and this is generally accepted as the standard on iOS.
        // If, however, you do wish to show underlines, you can enable them like so:
        label.linksHaveUnderlines = true
    }
    
    func makeButton() {
        toggleButton = UIImageView()
        toggleButton!.backgroundColor = UIColor.clearColor()
        
        toggleButton!.image = UIImage(named: "collapse_guide")
        toggleButton!.image = UIImage(named: "expand_guide")
    }
    
    func LayoutTitlePanel() {
        if let _titleLabel: UILabel = titleLabel, _likeCountLabel: UILabel = likeCountLabel, _toggleButton: UIImageView = toggleButton {
            layout(_titleLabel, _likeCountLabel, _toggleButton) {
                view1, view2, view3 in
                
                // _titleLabel
                view1.leading == view1.superview!.leading + 20
                view1.trailing == view1.superview!.trailing - 200
                
                view1.top == view1.superview!.top + 10
                view1.height == 14
                
                // _likeCountLabel
                view2.leading == view2.superview!.leading + 20
                view2.trailing == view2.superview!.trailing - 200
                
                view2.top == view1.bottom + 4
                view2.height == 14
                
                // _toggleButton
                view3.top == view3.superview!.top
                view3.trailing == view3.superview!.trailing
                
                view3.width == VIDEO_INFO_TOGGLE_WIDTH_HEIGHT
                view3.height == VIDEO_INFO_TOGGLE_WIDTH_HEIGHT
            }
        }
    }
    
    func showToggleImage(isOpen:Bool) {
        println("btnTouched: + \(isOpen)")
        if (isOpen == true) {
            self.toggleButton!.image = UIImage(named: "expand_guide")
        } else {
            self.toggleButton!.image = UIImage(named: "collapse_guide")
        }
    }
    
    func playTapped() {
        if let infoObject: VideoInfoObject = videoInfoObject {
            infoObject.videoInfoToggleProtocol!.toggleVideoInfoPanel({
                (object, isOpen) -> Void in
                
            })
        }
    }
    
}