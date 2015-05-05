//
//  ViewController.swift
//  appRestApp
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AuthorUserFetchingDelegate, UISearchBarDelegate, UIPopoverControllerDelegate {

    var searchActive: Bool = false

    var popoverController: UIPopoverController?
    var popoverTableViewController: PopoverTableViewController = PopoverTableViewController()

    var rightBarItem: UIBarButtonItem?

    lazy var searchBar: UISearchBar = {
        let _searchBar: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 300, 20))
        _searchBar.placeholder = "Searching..."

        _searchBar.backgroundColor = UIColor.clearColor()
        _searchBar.showsCancelButton = true
        _searchBar.userInteractionEnabled = true

        return _searchBar
    }()

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AuthoredFetcher.sharedInstance.delegate = self
        if (YoutubeUserProfile.sharedInstance.hasLogin() == true) {
            loginButton.enabled = false
            loginButton.backgroundColor = UIColor.redColor()

            //            self.startFetchingLoggedSubscriptionList() // used
        }

        rightBarItem = UIBarButtonItem(customView: searchBar)
        //        searchBar.parentItem = rightBarItem
        self.navigationItem.rightBarButtonItem = rightBarItem

        searchBar.delegate = self

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginTapped(sender: AnyObject) {
        let viewController: GTMOAuth2ViewControllerTouch =
        GTMOAuth2ViewControllerTouch(scope: scope, clientID: kMyClientID, clientSecret: kMyClientSecret, keychainItemName: keychainItemName) {
            (controllerTouch, auth, error) -> Void in

            if (error != nil) {
                // Authentication failed

            } else {
                // Authentication succeeded
                YoutubeUserProfile.sharedInstance.authorizeRequest(auth)
                self.startFetchingLoggedSubscriptionList()
                self.dismissViewControllerAnimated(true, completion: {
                    () -> Void in

                })
            }
        }

        let navCon: UINavigationController = UINavigationController(rootViewController: viewController)
        navCon.providesPresentationContextTransitionStyle = true
        navCon.definesPresentationContext = true
        navCon.modalPresentationStyle = .PageSheet


        self.presentViewController(navCon, animated: true) {
            () -> Void in

        }
    }

    func startFetchingLoggedSubscriptionList() {
        AuthoredFetcher.sharedInstance.initLoggedUser()
    }

    // MARK: AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel) {
    }

    func endFetchingUserSubscriptions(array: NSArray) {
    }


    func fetchAutoCompleteSuggestions(searchWish: String) {
        YoutubeDataFetcher.sharedInstance.autoCompleteSuggestionsWithSearchWish(searchWish, completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                self.popoverTableViewController.contents = (object as! NSArray) as! [String]
            }
        })
    }


    func showPopover() {
        if (popoverController != nil) {
            return
        }

        popoverController = UIPopoverController(contentViewController: popoverTableViewController)
        popoverController?.presentPopoverFromBarButtonItem(rightBarItem!, permittedArrowDirections: .Any, animated: true)

        popoverController?.delegate = self
    }


    // MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;

        showPopover()
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;

        popoverController = nil
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        showPopover()

        let searchWish = searchBar.text
        

        if (searchWish.isEmpty == false) {
            self.fetchAutoCompleteSuggestions(searchBar.text)
        }

    }


}

