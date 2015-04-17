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
    var tableContents:[NIDrawRectBlockCellObject] = [NIDrawRectBlockCellObject]()
    var cellFactory:NICellFactory?
    var model:NITableViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeModel()
        
        tableView.dataSource = model
    }

    func makeModel(){
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