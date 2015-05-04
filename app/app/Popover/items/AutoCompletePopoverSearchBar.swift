//
//  AutoCompletePopoverSearchBar.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class AutoCompletePopoverSearchBar: UISearchBar {
    var autoCompleteResults: [String] = [String]()
    var popoverController: UIPopoverController?


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func reloadData() {

    }

    func hideAutoCompleteView() {

    }

}