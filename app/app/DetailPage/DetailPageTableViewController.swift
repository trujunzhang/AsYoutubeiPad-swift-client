//
//  DetailPageTableViewController.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class DetailPageTableViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource,VideoInfoToggleProtocol {
    
    var videoInfoObject: VideoInfoObject?
    
    var pageSections:[DetailPageSection] = [DetailPageSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func makeVideoInfoSection(videoInfoObject: VideoInfoObject){
        self.videoInfoObject = videoInfoObject
        self.pageSections.append(DetailPageSection.makeVideoInfoSection(self.videoInfoObject!))
        
        self.tableView.reloadData()
    }
    
    func appendSideVideos(array:NSArray){
        //        self.pageSections.append(DetailPageSection.makeSuggestionVideoListSection(array))
        
        //        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addVideoInfo(videoInfoObject: VideoInfoObject){
        self.videoInfoObject = videoInfoObject
    }
    
    
    
    //MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.pageSections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section:DetailPageSection = self.pageSections[section]
        return section.rowObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section:DetailPageSection = self.pageSections[indexPath.section]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(section.identifer, forIndexPath: indexPath) as! UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        let section:DetailPageSection = self.pageSections[forRowAtIndexPath.section]
        let rowObject: AnyObject = section.rowObjects[forRowAtIndexPath.row]
        let sectionIdentifier :    DetailPageCellIdentifier = section.sectionIdentifier!
        
        switch(sectionIdentifier){
        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            let videoInfoCell: VideoInfoTableViewCell = cell as! VideoInfoTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoInfoObject)
            videoInfoCell.videoInfoToggleProtocol = self
            break;
            
        case DetailPageCellIdentifier.ChannelInfoCellIdentifier:
            let videoInfoCell: ChannelInfoTableViewCell = cell as! ChannelInfoTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoInfoObject)
            break;
            
        case DetailPageCellIdentifier.SuggestionListCellIdentifier:
            let videoInfoCell: SuggestionVideoInfoTableViewCell = cell as! SuggestionVideoInfoTableViewCell
            videoInfoCell.configureCell(rowObject as! YoutubeVideoCache)
            break;
            
        default:
            let x = 0
            break;
            
        }
    }
    
    //MARK: UITableViewDelegate
    
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section:DetailPageSection = self.pageSections[indexPath.section]
        let sectionIdentifier :    DetailPageCellIdentifier = section.sectionIdentifier!
        
        var rowHeight:CGFloat = 0
        switch(sectionIdentifier){
        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            let rowObject: VideoInfoObject = section.rowObjects[indexPath.row] as! VideoInfoObject
            rowHeight = rowObject.currentRowHeight + VIDEO_INFO_TITLE_PANEL_HEIGHT
            break;
            
        case DetailPageCellIdentifier.ChannelInfoCellIdentifier:
            break;
            
        case DetailPageCellIdentifier.SuggestionListCellIdentifier:
            rowHeight = 140
            break;
            
        default:
            
            break;
            
        }
        
        
        return rowHeight
    }
    
    //    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
    //
    //    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 0
    //    }
    //
    //    override  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return UIView()
    //    }
    //
    //    override  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //
    //        return UIView()
    //    }
    
    
    // MARK: Video Info tableview cell's animate
    
    func updateAnimatedTableCell() {
        if let _tableView: UITableView = tableView {
            _tableView.beginUpdates()
            _tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            _tableView.endUpdates()
        }
    }
    
    func performAnimation() {
        self.videoInfoObject?.prepareAnimate()
        
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
        self.performAnimation()
    }
    
    
    
    
    
}
