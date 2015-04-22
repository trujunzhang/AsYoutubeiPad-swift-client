//
//  NBMenuTableViewController.swift
//  app
//
//  Created by djzhang on 4/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class NBMenuTableViewController: UIViewController,UITableViewDelegate {
    
    var model: NIMutableTableViewModel?
    var tableView: UITableView?
    var cellFactory: NICellFactory?
    
    var videoInfoObject: VideoInfoObject?
    var obj: NIDrawRectBlockCellObject?
    
    var tableContents: [AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)
        
        makeModel()
        
        tableView = UITableView()
        
        self.view.addSubview(tableView!)
        
        layout(tableView!) {
            view1 in
            
            view1.leading == view1.superview!.leading + VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
            view1.trailing == view1.superview!.trailing - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
            
            view1.top == view1.superview!.top + 20 + 100
            view1.bottom == view1.superview!.bottom - 20
        }
        
        tableView?.dataSource = model
        tableView?.delegate = self
        
        //        tableView?.rowHeight = 100
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    // MARK : model
    func makeModel() {
        let drawTextBlock: NICellDrawRectBlock = {
            rect, object, cell in
            
            return 0
        }
        
        videoInfoObject = VideoInfoObject()
        obj = NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject)
        tableContents = [
            NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
            NITitleCellObject(title: "toggle"),
            NITitleCellObject(title: "xcode"),
            NITitleCellObject(title: "wanghao")
        ]
        
        cellFactory = NICellFactory()
        cellFactory?.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
        
        model = NIMutableTableViewModel(listArray: tableContents, delegate: cellFactory)
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

    // MARK: NIMutableTableViewModelDelegate
//    tableview
    
    
}