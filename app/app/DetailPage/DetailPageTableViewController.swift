//
//  DetailPageTableViewController.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class DetailPageTableViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource {
    
    var pageSections:[DetailPageSection] = [DetailPageSection]()
    var videoInfoTappedEnable : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.separatorStyle = .None
    }
    
    func makeVideoInfoSection(videoCache: YoutubeVideoCache,videoInfoTappedEnable : Bool){
        self.videoInfoTappedEnable = videoInfoTappedEnable
        
        let  videoInfoSections:[DetailPageSection] =  DetailPageSection.insertVideoInfoSection(videoCache,videoInfoTappedEnable:self.videoInfoTappedEnable )
        for section in videoInfoSections {
            pageSections.append(section)
        }
        
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
            
            break;
        case DetailPageCellIdentifier.VideoDescriptionCellIdentifier:
            
            let videoInfoCell: VideoDescriptionTableViewCell = cell as! VideoDescriptionTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoDescriptonObject)
            
            break;
        case DetailPageCellIdentifier.VideoStatisticCellIdentifier:
            
            let videoInfoCell: VideoStatisticTableViewCell = cell as! VideoStatisticTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoStatisticObject)
            
            break;
            
        case DetailPageCellIdentifier.ChannelInfoCellIdentifier:
            let videoInfoCell: ChannelInfoTableViewCell = cell as! ChannelInfoTableViewCell
            //            videoInfoCell.configureCell(rowObject as! VideoInfoObject)
            break;
            
        case DetailPageCellIdentifier.SuggestionListCellIdentifier:
            let videoInfoCell: SuggestionVideoInfoTableViewCell = cell as! SuggestionVideoInfoTableViewCell
            videoInfoCell.configureCell(rowObject as! YoutubeVideoCache)
            break;
            
        default:
            break;
        }
    }
    
    
    //MARK: UITableViewDelegate
    
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0 && videoInfoTappedEnable == true){
            self.toggleVideoDesctionAnimation()
        }
    }
    
    func toggleVideoDesctionAnimation(){
        let section:DetailPageSection = self.pageSections[0]
        
        self.tableView.beginUpdates()
        
        let animatedIndexPath = NSIndexPath(forRow: 0, inSection: 1)
        if(section.isOpen == true){
            DetailPageSection.removeAnimatedObject(self.pageSections[1], index: 0)
            self.tableView.deleteRowsAtIndexPaths([animatedIndexPath], withRowAnimation: .Automatic)
        }else{
            DetailPageSection.addAnimatedObject(self.pageSections[1], index: 0)
            self.tableView.insertRowsAtIndexPaths([animatedIndexPath], withRowAnimation: .Automatic)
        }
        
        self.tableView.endUpdates()
        
        section.isOpen = !section.isOpen
        
    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section:DetailPageSection = self.pageSections[indexPath.section]
        let sectionIdentifier :    DetailPageCellIdentifier = section.sectionIdentifier!
        
        //        println("rowHeight is \(section.rowHeight)")
        
        return section.rowHeight
    }
    
    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section:DetailPageSection = self.pageSections[section]
        
        return section.sectionHeaderHeight
    }
    
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section:DetailPageSection = self.pageSections[section]
        return section.sectionFooterHeight
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
    
    
    
    
    
}
