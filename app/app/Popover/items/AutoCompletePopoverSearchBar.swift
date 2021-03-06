//
//  AutoCompletePopoverSearchBar.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class AutoCompletePopoverSearchBar: UISearchBar, UISearchBarDelegate, UIPopoverControllerDelegate, PopoverContentSelectedProtocol {
    var autoCompleteResults: [String] = [String]()
    var popoverController: UIPopoverController?

    var popoverEvent: PopoverEvent?

    var lastSearchWish = ""

    // MARK:
    var rightBarItem: UIBarButtonItem?
    lazy var popoverTableViewController: PopoverTableViewController = {
        let contentViewController: PopoverTableViewController = PopoverTableViewController()

        contentViewController.contentSelectedDelegate = self

        return contentViewController
    }()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        //        UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
        delegate = self
    }

    // MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        showPopover()
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.popoverController!.dismissPopoverAnimated(false)
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.popoverController!.dismissPopoverAnimated(false)
        self.resignFirstResponder()
        RevealViewHelper.sharedInstance.showSearchResultPanel(searchBar.text)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        showPopover()

        if (isSameSearchWish(searchBar.text) == false) {
            popoverEvent?.startPopoverEvent(searchBar.text.trim(), handler: {
                (object) -> Void in
                self.popoverTableViewController.contents = object as! [String]
            })
        }
    }

    func isSameSearchWish(searchWish: String) -> Bool {
        if (searchWish.trim() == lastSearchWish.trim()) {
            return true
        }

        lastSearchWish = searchWish
        return false
    }


    // MARK: AutoCompleteProtocol
    func showPopover() {
        if (popoverController != nil) {
            return
        }

        popoverController = UIPopoverController(contentViewController: popoverTableViewController)

        if let thePopoverController: UIPopoverController = popoverController {
            thePopoverController.presentPopoverFromBarButtonItem(rightBarItem!, permittedArrowDirections: .Any, animated: false)

            thePopoverController.delegate = self
            self.popoverController = thePopoverController
        }
    }


    // MARK: PopoverContentSelectedProtocol
    func didPickItemFromPopover(content: AnyObject) {
//        self.popoverController!.dismissPopoverAnimated(false)
        self.text = content as! String

        searchBarSearchButtonClicked(self)
    }

    // MARK: NSNotificationCenter
    func onKeyboardHide() {
        if (self.popoverController != nil) {
            self.popoverController = nil
        }
    }

    // MARK: UIPopoverControllerDelegate
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        self.popoverController = nil
        self.resignFirstResponder()
    }


}