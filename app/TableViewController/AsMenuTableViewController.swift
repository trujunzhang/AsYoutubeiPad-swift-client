//
//  AsMenuTableViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/16/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit



class AsMenuTableViewController: UIViewController , ASTableViewDataSource, ASTableViewDelegate {


    var tableView: ASTableView
    var leftMenuSectionsUtils :LeftMenuSectionsUtils = LeftMenuSectionsUtils()
    var menuSections : [MenuSectionItemInfo] = []

    // MARK: UIViewController.
    required override init() {
        self.tableView = ASTableView()
        super.init(nibName: nil, bundle: nil)
        self.tableView.asyncDataSource = self
        self.tableView.asyncDelegate = self

        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None


        menuSections = self.leftMenuSectionsUtils.getSignInMenuItemTreeArray()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)

    }

    override func viewWillLayoutSubviews() {
        self.tableView.frame = self.view.bounds

    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: ASTableView data source and delegate.
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let row = menuSections[indexPath.section].rows[indexPath.row]
        let cell = AsMenuTableRowCell(nodeCellSize: CGSizeMake(256, 60), title: row.title, iconUrl: row.imageUrl, isRemoteImage: false)

        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return menuSections.count
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].rows.count
    }

    //- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String {
        return menuSections[section].headerTitle
    }



    // MARK: ASTableView table view and delegate.

}
