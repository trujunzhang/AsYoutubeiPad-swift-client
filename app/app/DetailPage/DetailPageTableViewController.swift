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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None
    }
    
    func makeVideoInfoSection(videoCache: YoutubeVideoCache){
        self.pageSections.append(DetailPageSection.makeVideoInfoSection(videoCache))
        
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
        
        let identifer = getCellIdentifer(indexPath, section: section)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath) as! UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        
        return cell
    }
    
    func getCellIdentifer(indexPath: NSIndexPath,section:DetailPageSection ) -> String{
        if(section.sectionIdentifier == DetailPageCellIdentifier.VideoInfoCellIdentifier){
            return VIDEO_ROWS_IDENTIFER[indexPath.row]
        }
        
        return section.identifer
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        let section:DetailPageSection = self.pageSections[forRowAtIndexPath.section]
        let rowObject: AnyObject = section.rowObjects[forRowAtIndexPath.row]
        let sectionIdentifier :    DetailPageCellIdentifier = section.sectionIdentifier!
        
        switch(sectionIdentifier){
        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            configureVideoInfoCell(cell,rowObject:rowObject,forRowAtIndexPath:forRowAtIndexPath)
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
    
    func configureVideoInfoCell(cell: UITableViewCell,rowObject: AnyObject,forRowAtIndexPath: NSIndexPath){
        switch(forRowAtIndexPath.row){
        case 0:
            let videoInfoCell: VideoInfoTableViewCell = cell as! VideoInfoTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoInfoObject)
            break;
        case 1:
            let videoInfoCell: VideoDescriptionTableViewCell = cell as! VideoDescriptionTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoDescriptonObject)
            break;
        case 2:
            let videoInfoCell: VideoStatisticTableViewCell = cell as! VideoStatisticTableViewCell
            videoInfoCell.configureCell(rowObject as! VideoStatisticObject)
            break;
        default:
            break;
        }
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
            switch(indexPath.row){
            case 0:
                rowHeight = 60
                break;
            case 1:
               rowHeight = 140
                break;
            case 2:
                rowHeight = 60
                break;
            default:
                break;
            }

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
    
    
    
    
    
}
