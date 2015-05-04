//
//  PopoverTableViewController.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class PopoverTableViewController: UITableViewController {

    var contents: [AnyObject] = [AnyObject]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK : model
    func makeModel(tableContents: [AnyObject]) -> NITableViewModel {
        let model: NITableViewModel = NimbusViewModelUtils.makeNITableViewModel(tableContents)

        // We are going to show how to recompile the section index so we provide the settings here.
        model.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch: false, showsSummary: false)

        return model
    }

}