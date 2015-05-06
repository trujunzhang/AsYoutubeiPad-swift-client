//
//  PopoverTableViewController.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class PopoverTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

//    var contents = ["San Francisco", "New York", "San Jose", "Chicago", "Los Angeles", "Austin", "Seattle"]

    var contentSelectedDelegate: PopoverContentSelectedProtocol?

    var contents: [String] = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell;
        cell.textLabel?.text = contents[indexPath.row];

        return cell;
    }

    //MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.contentSelectedDelegate?.didPickItemFromPopover(contents[indexPath.row])
    }


}