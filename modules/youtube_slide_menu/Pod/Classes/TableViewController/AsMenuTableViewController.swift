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

 // MARK: UIViewController.
 required override init() {

 self.tableView = ASTableView()
 super.init(nibName: nil, bundle: nil)
 self.tableView.asyncDataSource = self
 self.tableView.asyncDelegate = self

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
 let patter = NSString(format: "[%ld.%ld] says hello!", indexPath.section, indexPath.row)
 let node = ASTextCellNode()
 node.text = patter
 return node
 }

 func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
 return 1
 }

 func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
 return 20
 }

}
