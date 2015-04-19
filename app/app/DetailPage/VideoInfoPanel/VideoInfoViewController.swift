//
//  VideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class VideoInfoViewController :UIViewController,UITableViewDelegate {
    
    var model: NITableViewModel?
    var tableView : UITableView?
    var isOpen:Bool = false
    var cellFactory : NICellFactory?
    
    var videoInfoObject:VideoInfoObject?
    var obj:NIDrawRectBlockCellObject?
    var tableContents:[AnyObject] = [AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        makeModel()
        tableView = UITableView()
        
        self.view.addSubview(tableView!)
        
        LayoutUtils.LayoutFullView(tableView!)
        
        tableView?.dataSource = model
        tableView?.delegate = self
        
        tableView?.rowHeight = 140
        
        isOpen = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK : model
    func makeModel(){
        let  drawTextBlock:NICellDrawRectBlock = {
            rect,  object,  cell in
            
            
            return 100
        }
        
        videoInfoObject = VideoInfoObject()
        obj = NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject)
        tableContents = [
             NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
            NITitleCellObject(title: "xcode"),
            NITitleCellObject(title: "wanghao")
        ]
        
        cellFactory = NICellFactory()
        cellFactory?.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
        
        model = NITableViewModel(listArray: tableContents, delegate: cellFactory)
        
    }
    
    
}