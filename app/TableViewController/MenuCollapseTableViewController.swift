//
//  MenuCollapseTableViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class MenuCollapseTableViewController : UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    let nodeConstructionQueue = NSOperationQueue()
    
    
    var leftMenuSectionsUtils :LeftMenuSectionsUtils = LeftMenuSectionsUtils()
    var menuSections : [MenuSectionItemInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        //        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
        menuSections = self.leftMenuSectionsUtils.getSignInMenuItemTreeArray()
        //        }else{
        //            menuSections = self.leftMenuSectionsUtils.getSignOutMenuItemTreeArray()
        //        }
        
        //        YoutubeFetcher.sharedInstance._delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: ASTableView data source and delegate.
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuSections[section].rows.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sectionInfo : MenuSectionItemInfo = menuSections[indexPath.section]
        let row = sectionInfo.rows[indexPath.row]
        
        var isRemoteImage = sectionInfo.isRemoteImage
        var rowType :MenuRowType = sectionInfo.rowType
        
        let identifier: String = "tableCell"
        
        var cell: MenuCollapseTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? MenuCollapseTableCell
        
        if cell == nil {
            cell = MenuCollapseTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell.setupCell(row.title, iconUrl: row.imageUrl, isRemoteImage: isRemoteImage)
        
                
        return cell!
    }
    
    
    
    // MARK: ASTableCellProtocols delegate.
    func updateForRowAtIndexPath(indexPath: NSIndexPath!, rowType:LeftTableRowType){
        //        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    // MARK: - protocol for AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel :GTLYouTubeChannel){
        self.updateForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), rowType: .LeftTableRowType_Header)
    }
    
    func endFetchingUserSubscriptions(array:NSArray){
        var rows : [MenuRowItemInfo] =  YoutubeModelParser.convertToMenuRowArrayFromSubscriptions(array)
        menuSections = self.leftMenuSectionsUtils.getSignInMenuItemTreeArrayWithSubscriptions(rows)
        
        var indexSet : NSMutableIndexSet = NSMutableIndexSet()
        indexSet.addIndex(2)
        indexSet.addIndex(3)
        //        self.tableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
    
}
