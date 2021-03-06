//
//  MenuCollapseTableViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class MenuCollapseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AuthorUserFetchingDelegate {
    
    @IBOutlet var tableView: UITableView!
    let nodeConstructionQueue = NSOperationQueue()
    
    
    var leftMenuSectionsUtils: LeftMenuSectionsUtils = LeftMenuSectionsUtils()
    var menuSections: [MenuSectionItemInfo] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setupViewController()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViewController()
    }
    
    func setupViewController() {
        
        
        //        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
        menuSections = self.leftMenuSectionsUtils.getSignInMenuItemTreeArray()
        //        } else {
        //            menuSections = self.leftMenuSectionsUtils.getSignOutMenuItemTreeArray()
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //        self.tableView.exclusiveSections = true
        
        self.tableView.reloadData()
        
        //        self.tableView.openSection(0, animated: true)
        //        self.tableView.openSection(1, animated: true)
        
        self.setupTableHeaderView()
        
        YoutubeFetcher.sharedInstance._delegate = self
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableHeaderView() {
        var headerViewController: UIViewController
        if(YoutubeUserProfile.sharedInstance.isLogin == true){
            //                    if (YoutubeUserProfile.sharedInstance.isLogin == false) {
            headerViewController =
                self.storyboard!.instantiateViewControllerWithIdentifier("MenuTableLoggedHeaderView") as! UIViewController
        } else {
            headerViewController =
                self.storyboard!.instantiateViewControllerWithIdentifier("MenuTableSignInHeaderView") as! UIViewController
        }
        
        let headerView:UIView = UIView()
        headerView.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
        headerView.addSubview(headerViewController.view)
        
        self.addChildViewController(headerViewController)
        
        self.tableView.tableHeaderView = headerView
    }
    
    
    
    // MARK: ASTableView data source and delegate.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].rows.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuSections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sectionInfo: MenuSectionItemInfo = menuSections[indexPath.section]
        let row = sectionInfo.rows[indexPath.row]
        
        var isRemoteImage = sectionInfo.isRemoteImage
        var rowType: MenuRowType = sectionInfo.rowType
        
        let identifier: String = "tableCell"
        
        var cell: MenuCollapseTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? MenuCollapseTableCell
        
        if cell == nil {
            cell = MenuCollapseTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell.setupCell(row.title, iconUrl: row.imageUrl, isRemoteImage: isRemoteImage)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionInfo: MenuSectionItemInfo = menuSections[section]
        
        var menuSectionHeaderView: MenuSectionHeaderView =
        self.storyboard!.instantiateViewControllerWithIdentifier("MenuSectionHeaderView") as! MenuSectionHeaderView
        
        menuSectionHeaderView.setupView(sectionInfo.headerTitle)
        
        let headerViewInSection:UIView = UIView()
        headerViewInSection.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_SECTION_HEADER_HEIGHT)
        headerViewInSection.addSubview(menuSectionHeaderView.view)
        
        
        return headerViewInSection
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         var sectionInfo: MenuSectionItemInfo = menuSections[section]
        if(sectionInfo.isHideTitle == true){
            return 0
        }
        return TABLE_SECTION_HEADER_HEIGHT
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TABLE_ROW_HEIGHT
    }
    
    
    // MARK: ASTableCellProtocols delegate.
    func updateForRowAtIndexPath(indexPath: NSIndexPath!, rowType: LeftTableRowType) {
        //        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    // MARK: - protocol for AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel) {
        self.updateForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), rowType: .LeftTableRowType_Header)
    }
    
    func endFetchingUserSubscriptions(array: NSArray) {
        var rows: [MenuRowItemInfo] = YoutubeModelParser.convertToMenuRowArrayFromSubscriptions(array)
        menuSections = self.leftMenuSectionsUtils.getSignInMenuItemTreeArrayWithSubscriptions(rows)
        
        self.tableView.reloadData()
        //        self.tableView.openSection(1, animated: true)
        //        self.tableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
    
}
