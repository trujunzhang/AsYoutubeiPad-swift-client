//
//  NBMenuTableViewController.swift
//  app
//
//  Created by djzhang on 4/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class NBMenuTableViewController: UIViewController, UITableViewDelegate, NBMenuTitleBarTapProtocol, AuthorUserFetchingDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var loadingPanel: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var model: NIMutableTableViewModel?
    var cellFactory: NICellFactory?

    var tableModelRowInfo: NBTableModelRowInfo?

    var tableData: [MenuSectionItemInfo] = [MenuSectionItemInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()
        YoutubeFetcher.sharedInstance.delegate = self

        // create NICellFactory instance
        cellFactory = NICellFactory()

        if let theCellFactory: NICellFactory = cellFactory {
            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
//            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: MenuTitleBarCellObject.self)
        }

        if let theTableView: UITableView = tableView {
            theTableView.backgroundColor = UIColor.clearColor()
            theTableView.separatorStyle = .None

            theTableView.delegate = self
        }


        if (YoutubeUserProfile.sharedInstance.hasLogin() == true) {
            self.startFetchingLoggedSubscriptionList()
        } else {
            hideLoadingPanel()
            createSections([])
        }
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }



    // MARK : model
    func makeModel(tableContents: [AnyObject]) -> NIMutableTableViewModel {
        let drawTextBlock: NICellDrawRectBlock = {
            rect, object, cell in

            return 0
        }

        let model: NIMutableTableViewModel = NIMutableTableViewModel(listArray: tableContents, delegate: cellFactory)

        // We are going to show how to recompile the section index so we provide the settings here.
        model.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch: false, showsSummary: false)

        return model
    }

    func createSections(array: NSArray) {
        var tableData: [MenuSectionItemInfo] = [MenuSectionItemInfo]()
        if (YoutubeUserProfile.sharedInstance.hasLogin() == true) {
            let subscriptionData: [MenuRowItemInfo] = YoutubeModelParser.convertToMenuRowArrayFromSubscriptions(array)
            tableData = LeftMenuSectionsUtils.getSignInMenuItemTreeArrayWithSubscriptions(subscriptionData)
        } else {
            tableData = LeftMenuSectionsUtils.getSignOutMenuItemTreeArray()
        }

        var userInfo: LoggedUserInfo = LoggedUserInfo()
        if (YoutubeUserProfile.sharedInstance.hasLogin()) {
            userInfo = LoggedUserInfo(userName: YoutubeUserProfile.sharedInstance.userChannel.userName, email: YoutubeUserProfile.sharedInstance.userChannel.email)
        }
//        println(YoutubeUserProfile.sharedInstance.userChannel.simpleDescription)
        tableModelRowInfo = NBMenuSectionGenerator.generatorSections(tableData, menuTitleBarTapProtocol: self, userInfo: userInfo)

        model = makeModel(tableModelRowInfo!.tableContents)

        reloadTableView(model!)
    }

    func reloadTableView(model: NIMutableTableViewModel) {
        if let theTableView: UITableView = tableView {
            theTableView.dataSource = model
            theTableView.reloadData()
        }
    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableModelRowInfo!.tableRowHeights[indexPath.row]
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {

        }
    }

    // MARK: NBMenuTitleBarTapProtocol
    func showLoginPanel() -> Void {
        let viewController: GTMOAuth2ViewControllerTouch =
        GTMOAuth2ViewControllerTouch(scope: scope, clientID: kMyClientID, clientSecret: kMyClientSecret, keychainItemName: keychainItemName) {
            (controllerTouch, auth, error) -> Void in

            if (error != nil) {
                // Authentication failed

            } else {
                // Authentication succeeded
                YoutubeUserProfile.sharedInstance.authorizeRequest(auth)
                self.startFetchingLoggedSubscriptionList()
                self.reloadTableView(NIMutableTableViewModel(delegate: nil))
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
        showLoadingPanel()
        YoutubeFetcher.sharedInstance.initLoggedUser()
    }

    // MARK :
    func showLoadingPanel() {
        loadingPanel.hidden = false
        loadingView.startAnimating()
        loadingView.hidesWhenStopped = true
    }

    func hideLoadingPanel() {
        loadingPanel.hidden = true
        loadingView.stopAnimating()
    }


    // MARK: AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel) {

    }

    func endFetchingUserSubscriptions(array: NSArray) {
        // First of all,hide loading panel
        hideLoadingPanel()

        // Then reload tableview
        createSections(array)
    }

}