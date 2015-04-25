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

    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var model: NIMutableTableViewModel?
    var cellFactory: NICellFactory?

    var videoInfoObject: VideoInfoObject?
    var obj: NIDrawRectBlockCellObject?

    var tableModelRowInfo: NBTableModelRowInfo?

    var tableData: [MenuSectionItemInfo] = [MenuSectionItemInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)
        YoutubeFetcher.sharedInstance.delegate = self

        createSections()
        makeModel()

        showLoadingPanel()

        if let theTableView: UITableView = tableView {
            theTableView.backgroundColor = UIColor.clearColor()
            theTableView.separatorStyle = .None

//            theTableView.dataSource = model
            theTableView.delegate = self
        }
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }



    // MARK : model
    func makeModel() {
        let drawTextBlock: NICellDrawRectBlock = {
            rect, object, cell in

            return 0
        }

        videoInfoObject = VideoInfoObject()
        obj = NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject)

        cellFactory = NICellFactory()

        if let theCellFactory: NICellFactory = cellFactory {
            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: MenuTitleBarCellObject.self)
        }

        model = NIMutableTableViewModel(listArray: tableModelRowInfo!.tableContents, delegate: cellFactory)

        // We are going to show how to recompile the section index so we provide the settings here.
        model!.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch: false, showsSummary: false)

    }

    func createSections() {
        let tableData: [MenuSectionItemInfo] = LeftMenuSectionsUtils.getSignOutMenuItemTreeArray()

        tableModelRowInfo = NBMenuSectionGenerator.generatorSections(tableData, menuTitleBarTapProtocol: self)
    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableModelRowInfo!.tableRowHeights[indexPath.row]
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            //            performAnimation()
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
                YoutubeFetcher.sharedInstance.initLoggedUser()
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

    // MARK :
    func showLoadingPanel(){
        loadingView.startAnimating()
        loadingView.hidesWhenStopped = true
    }

    func hideLoadingPanel(){
        loadingView.stopAnimating()
    }


    // MARK: AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel){
        let x = 0
    }

    func endFetchingUserSubscriptions(array: NSArray){

    }

}