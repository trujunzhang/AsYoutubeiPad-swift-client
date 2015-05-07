//
//  VideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class VideoInfoViewController: UIViewController, UITableViewDelegate, VideoInfoToggleProtocol {
    
    var videoID: String = "" {
        didSet {
            fetchVideoInfo()
        }
    }
    
    var model: NITableViewModel?
    var tableView: UITableView?
    var cellFactory: NICellFactory?
    
    var videoInfoObject: VideoInfoObject?
    
    var tableContents: [AnyObject] = [AnyObject]()
    
    func fetchVideoInfo(){
        YoutubeFetcher.fetchVideoDescription(videoID, completeHandler: {
            (object, sucess) -> Void in
            
            if (sucess == true) {
                let array:NSArray = object as! NSArray
                if(array.count == 1){
                   self.reloadTableData(array[0] as! YoutubeVideoCache)
                }
            }else{
                
            }
            
        })
    }
    
    
    
    func reloadTableData(videoCache: YoutubeVideoCache){
        self.videoInfoObject =  VideoInfoObject.convertToVideoInfoObject(videoCache)
        
        self.calcuteVideoInfoRect()
        
        makeTableView()
        makeModel()
        
        tableView?.dataSource = model
        
    }
    
    func makeTableView(){
        
        tableView = UITableView()
        tableView?.delegate = self
        
        self.view.addSubview(tableView!)
        
        layout(tableView!) {
            view1 in
            
            view1.leading == view1.superview!.leading + VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
            view1.trailing == view1.superview!.trailing - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT - 600
            
            view1.top == view1.superview!.top + VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
            view1.bottom == view1.superview!.bottom - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func calcuteVideoInfoRect(){
        if let infoObject: VideoInfoObject = videoInfoObject {
            infoObject.videoInfoToggleProtocol = self
            let viewWidth = self.view.frame.size.width - (VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT * 2)
            //            println("viewWidth : \(viewWidth)")
            
            let specialRowHeight: CGFloat = VideoInfoDrawRectBlockCell.getBlockCellHeight(infoObject, width: viewWidth)
            //            println("specialRowHeight : \(specialRowHeight)")
            
            infoObject.setDescriptionMaxHeight(specialRowHeight, _descriptionWidth: viewWidth)
            
            let rect: CGRect = CGRectMake(VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT, VIDEO_INFO_TITLE_PANEL_HEIGHT,
                infoObject.descriptionWidth - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT * 2, specialRowHeight)
            
            infoObject.descriptionRect = rect
        }
    }
    
    // MARK : model
    func makeModel() {
        let drawTextBlock: NICellDrawRectBlock = {
            rect, object, cell in
            
            return 0
        }
        
        videoInfoObject = VideoInfoObject()
        tableContents = [
            NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
            NITitleCellObject(title: "toggle"),
            NITitleCellObject(title: "xcode"),
            NITitleCellObject(title: "wanghao")
        ]
        
        cellFactory = NICellFactory()
        cellFactory?.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
        
        model = NITableViewModel(listArray: tableContents, delegate: cellFactory)
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) {
            if let infoObject: VideoInfoObject = videoInfoObject {
                let height = infoObject.currentRowHeight + VIDEO_INFO_TITLE_PANEL_HEIGHT
                //                println("tablerow's height: \(height)")
                return height
            }
        }
        
        return 200
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            //            performAnimation()
        }
    }
    
    // MARK: tableview events
    
    func updateAnimatedTableCell() {
        if let _tableView: UITableView = tableView {
            _tableView.beginUpdates()
            _tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            _tableView.endUpdates()
        }
    }
    
    @IBAction func xxx(sender: AnyObject) {
        //        performAnimation()
    }
    
    // MARK: Video Info tableview cell's animate
    func performAnimation(completionBlock: VideoToggleCompletionBlock) {
        videoInfoObject?.prepareAnimate()
        
        var name = kCAMediaTimingFunctionEaseIn
        var toValue: CGFloat = 0
        if (videoInfoObject!.isOpen == false) {
            name = kCAMediaTimingFunctionEaseOut
            toValue = videoInfoObject!.maxHeightValue
        }
        
        let spring: POPBasicAnimation = POPBasicAnimation()
        spring.timingFunction = CAMediaTimingFunction(name: name)
        spring.completionBlock = {
            (anim, finished) -> Void in
            //            self.videoInfoObject!.currentRowHeight = toValue
            //            self.updateAnimatedTableCell()
        }
        
        let property: POPAnimatableProperty = POPAnimatableProperty.propertyWithName("com.rwt.heightContstraint", initializer: {
            (object) -> Void in
            
            let prop: POPMutableAnimatableProperty = object as POPMutableAnimatableProperty
            
            // note the object used is NSLayoutConstraint, the same object we assign the animation to
            prop.readBlock = {
                (anyObject, values) -> Void in
                
                if let object: VideoInfoObject = anyObject as? VideoInfoObject {
                    values[0] = object.fromValue!
                }
                
            }
            
            prop.writeBlock = {
                (anyObject, values) -> Void in
                
                if let object: VideoInfoObject = anyObject as? VideoInfoObject {
                    object.fromValue = values[0]
                    self.videoInfoObject!.currentRowHeight = values[0]
                    
                    self.updateAnimatedTableCell()
                }
                
            }
            
            // this helps Pop determine when the animation is over
            prop.threshold = 0.01
            
        }) as! POPAnimatableProperty
        
        spring.property = property
        spring.toValue = toValue
        
        videoInfoObject!.isOpen = !(videoInfoObject!.isOpen)
        
        videoInfoObject!.pop_addAnimation(spring, forKey: "TableRowAnimate")
    }
    
    // MARK : VideoInfoToggleProtocol
    func toggleVideoInfoPanel(completionBlock: VideoToggleCompletionBlock) -> Void {
        performAnimation(completionBlock)
    }
    
    
}