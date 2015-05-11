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
    var videoInfoCellHeight : CGFloat = 0
    
    var pageSections:[DetailPageSection] = [DetailPageSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None
    }
    
    func makeVideoInfoSection(videoInfoObject: VideoInfoObject){
        self.videoInfoObject = videoInfoObject
        self.pageSections.append(DetailPageSection.makeVideoInfoSection(self.videoInfoObject!))
        
        self.tableView.reloadData()
    }
    
    func appendSideVideos(array:NSArray){
        self.pageSections.append(DetailPageSection.makeSuggestionVideoListSection(array))
        
        self.tableView.reloadData()
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
        if(section.sectionIdentifier == DetailPageCellIdentifier.VideoInfoCellIdentifier ){
            return 3
        }
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
            let videoInfoObject: VideoInfoObject = rowObject as! VideoInfoObject
            videoInfoCell.configureCell(videoInfoObject)
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
    
    func configureVideoInfoCell(){
        
    }
    
    //MARK: UITableViewDelegate
    
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView,
        shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool{
            
            return false
    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section:DetailPageSection = self.pageSections[indexPath.section]
        let sectionIdentifier :    DetailPageCellIdentifier = section.sectionIdentifier!
        
        var rowHeight:CGFloat = 0
        switch(sectionIdentifier){
        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            let rowObject: VideoInfoObject = section.rowObjects[indexPath.row] as! VideoInfoObject
            rowHeight = self.videoInfoCellHeight + VIDEO_INFO_TITLE_PANEL_HEIGHT
            
            println("currentRowHeight is \(rowHeight)")
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
    
    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section:DetailPageSection = self.pageSections[section]
        if(section.sectionTitle.isEmpty == true){
            return 0
        }
        return 50
    }
    
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell:HeaderTableViewCell = tableView.dequeueReusableCellWithIdentifier(HEADER_CELL_IDENTIFIER) as! HeaderTableViewCell
        //        headerCell.backgroundColor = UIColor.cyanColor()
        
        headerCell.configureCell( self.pageSections[section].sectionTitle)
        
        return headerCell
    }
    
    override  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        footerView.backgroundColor = UIColor.clearColor()
        
        return footerView
    }
    
    
    // MARK: Video Info tableview cell's animate
    
    func updateAnimatedTableCell(animatedHeight: CGFloat) {
          }
    
    
    // MARK : VideoInfoToggleProtocol
    func toggleVideoInfoPanel(object: VideoInfoObject) -> Void{
//        self.performAnimation(object)
    }
    
    
    
    
    
}
