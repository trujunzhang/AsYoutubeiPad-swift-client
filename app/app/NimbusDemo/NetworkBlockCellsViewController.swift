//
//  NetworkBlockCellsViewController.swift
//  app
//
//  Created by djzhang on 4/16/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class NetworkBlockCellsViewController : UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var drawTextBlock:NICellDrawRectBlock?
    var tableContents:[AnyObject] = [AnyObject]()
    var cellFactory:NICellFactory?
    var model:NITableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeModel()
        
        tableView.dataSource = model
    }
    
    func makeModel(){
        var drawTextBlock:NICellDrawRectBlock = { (rect, object, cell) -> CGFloat in
            
            let ret:CGFloat = 1.0
            return ret
            
        }
        
        
        var tableContents:[AnyObject]  = [
            NIDrawRectBlockCellObject.objectWithBlock(drawTextBlock, object: "wanghao")
        ]
        
        cellFactory = NICellFactory()
        if let factory : NICellFactory = cellFactory{
            factory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: NetworkDrawRectBlockCell.self)
            
            model = NITableViewModel(listArray: tableContents, delegate: factory)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK : UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 0
    }
    
}