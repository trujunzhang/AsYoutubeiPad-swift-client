//
//  AutoCompletePopoverController.swift
//  appRestApp
//
//  Created by djzhang on 5/5/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class AutoCompletePopoverController: UIPopoverController, UIPopoverControllerDelegate {

    override init(contentViewController viewController: UIViewController) {
        super.init(contentViewController: viewController)

        self.delegate = self
    }

    // MARK: UIPopoverControllerDelegate
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
//        self.searchBar.resignFirstResponder()
    }
}