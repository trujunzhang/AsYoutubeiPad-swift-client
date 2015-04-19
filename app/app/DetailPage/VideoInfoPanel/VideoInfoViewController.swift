//
//  VideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class VideoInfoViewController :UIViewController {

    var model: NITableViewModel?
    var tableView : UITableView?
    var open:Bool = false
    var cellFactory : NICellFactory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK : model
    func makeModel(){
        let  drawTextBlock:NICellDrawRectBlock = {
             rect,  object,  cell in
            
            
            return 0
        }
        
        
    }
    
    
}