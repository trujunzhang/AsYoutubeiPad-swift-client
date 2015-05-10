//
//  DetailPageTableViewController.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class DetailPageTableViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource {
    
    var videoInfoObject: VideoInfoObject = VideoInfoObject()
    
    var pageSections:[DetailPageSection] = [DetailPageSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.makeVideoInfoSection() // test
    }
    
    func makeVideoInfoSection(){
        let section:DetailPageSection = DetailPageSection.makeVideoInfoSection(self.videoInfoObject)
        self.pageSections.append(section)
        
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
        
        
    }
    
    //MARK: UITableViewDelegate
    
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    
    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    
    
    
}
