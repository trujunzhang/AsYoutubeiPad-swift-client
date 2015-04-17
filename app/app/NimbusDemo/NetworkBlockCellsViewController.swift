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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK : UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 0
    }
    
}