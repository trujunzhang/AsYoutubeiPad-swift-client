//
//  AutoCompletePopoverSearchBar.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class AutoCompletePopoverSearchBar: UISearchBar, UISearchBarDelegate {
    var autoCompleteResults: [String] = [String]()
    var popoverController: UIPopoverController?
    var autoCompleteDelegate: AutoCompleteProtocol?

    var searchActive: Bool = false

    var lastSearchWish = ""

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        delegate = self
    }

    // MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;

        autoCompleteDelegate?.showPopover()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;

        autoCompleteDelegate?.hidePopover()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        autoCompleteDelegate?.showPopover()

        if (isSameSearchWish(searchBar.text) == false) {
            autoCompleteDelegate?.search(searchBar.text.trim())
        }
    }

    func isSameSearchWish(searchWish: String) -> Bool {
        if (searchWish.trim() == lastSearchWish.trim()) {
            return true
        }

        lastSearchWish = searchWish
        return false
    }

}