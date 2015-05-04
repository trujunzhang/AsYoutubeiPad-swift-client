//
//  PopoverTableViewController.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class PopoverTableViewController: UITableViewController {
    var actions: NITableViewActions?
    var contents: [AnyObject] = [AnyObject]() {
        didSet {
            self.tableView.reloadData()
        }
    }


    func initialize() {
        actions = NITableViewActions(target: self)

    }

    // MARK : model
    func makeModel(tableContents: [AnyObject]) -> NITableViewModel {
        let model: NITableViewModel = NimbusViewModelUtils.makeNITableViewModel(tableContents)

        // We are going to show how to recompile the section index so we provide the settings here.
        model.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch: false, showsSummary: false)

        return model
    }

    func reloadTableContents(array: NSArray) {
        self.tableView.dataSource = makeModel(createTableContents(array) as [AnyObject])
        self.tableView.reloadData()
    }

    func createTableContents(array: NSArray) -> NSMutableArray {
        let contents: NSMutableArray = NSMutableArray()
        for title in array {
            let titleCell: NITitleCellObject = NITitleCellObject(title: title as! String)
            actions?.attachToObject(titleCell, tapBlock: {
                (object, controller, indexPath) -> Bool in

                return true
            })
            contents.addObject(titleCell)
        }

        return contents
    }

}