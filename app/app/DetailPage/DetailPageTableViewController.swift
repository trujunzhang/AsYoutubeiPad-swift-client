//
//  DetailPageTableViewController.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Dollar

class DetailPageTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Public ViewControllers
    lazy var loadingViewController: LoadingViewController = {
        return LoadingViewController.instance()
    }()
    lazy var requestFailureViewController: RequestFailureViewController = {
        return RequestFailureViewController.instance()
    }()

    var watchTableModel: VideoWatchTableModel = VideoWatchTableModel()
    var sectionKeys: [String] = [String]()
    var videoInfoTappedEnable: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None
    }

    func showLoadingPanel(parentViewController: UIViewController, superView: UIView) {
        self.tableView.hidden = true

        refreshControl?.endRefreshing()
        self.showAndAddLoadingPanel(loadingViewController, parentViewController: parentViewController, superView: superView)
    }

    func hideLoadingPanel() {
        self.tableView.hidden = false

        self.hideAndRemoveLoadingPanel(self.loadingViewController)
        refreshControl?.endRefreshing()
    }

    // MARK: -
    func emptyVideoInfoTable() {
        for (index, key) in enumerate(VIDEO_ROWS_INFO_IDENTIFER) {
            if ($.contains(self.sectionKeys, value: key) == true) {
                self.sectionKeys = $.remove(self.sectionKeys) {
                    $0 == key
                }
            }
        }
        self.tableView.reloadData()
    }

    // MARK : methods for Video Info sections
    func insertVideoInfoSection() {
        if (watchTableModel.containVideoInfo() == false) {
            return
        }

        for (index, key) in enumerate(VIDEO_ROWS_INFO_IDENTIFER) {

            if ($.contains(self.sectionKeys, value: key) == false) {
                self.tableView.beginUpdates()

                self.sectionKeys.insert(key, atIndex: index)

                self.tableView.insertSections(NSIndexSet(index: index), withRowAnimation: UITableViewRowAnimation.None)

                self.tableView.endUpdates()
            }
        }
    }


    func removeVideoInfoSection() {

        for (index, key) in enumerate(VIDEO_ROWS_INFO_IDENTIFER) {
            if ($.contains(self.sectionKeys, value: key) == true) {

                self.tableView.beginUpdates()

                self.sectionKeys = $.remove(self.sectionKeys) {
                    $0 == key
                }

                self.tableView.deleteSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.endUpdates()
            }
        }
    }

    // MARK: methods for Suggestion sections
    func appendSideVideos() {

        if ($.contains(self.sectionKeys, value: SECTION_TITLE_CELL_IDENTIFER) == false) {
            self.tableView.beginUpdates()

            self.sectionKeys.append(SECTION_TITLE_CELL_IDENTIFER)

            self.tableView.insertSections(NSIndexSet(index: self.sectionKeys.count - 1), withRowAnimation: UITableViewRowAnimation.None)

            self.tableView.endUpdates()
        }

        if ($.contains(self.sectionKeys, value: SUGGESTION_CELL_IDENTIFER) == false) {
            self.tableView.beginUpdates()

            self.sectionKeys.append(SUGGESTION_CELL_IDENTIFER)

            self.tableView.insertSections(NSIndexSet(index: self.sectionKeys.count - 1), withRowAnimation: UITableViewRowAnimation.None)

            self.tableView.endUpdates()
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionKeys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let section: DetailPageSection = getSectionByIndex(section)
        return section.rowObjects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section: DetailPageSection = getSectionByIndex(indexPath.section)

        let cell = tableView.dequeueReusableCellWithIdentifier(section.identifer, forIndexPath: indexPath) as! UITableViewCell

        configureCell(cell, forRowAtIndexPath: indexPath)

        return cell
    }


    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        let section: DetailPageSection = getSectionByIndex(forRowAtIndexPath.section)
        let rowObject: AnyObject = section.rowObjects[forRowAtIndexPath.row]
        let sectionIdentifier: DetailPageCellIdentifier = section.sectionIdentifier!

        switch (sectionIdentifier) {

        case DetailPageCellIdentifier.SectionTitleCellIdentifier:
            let cell: HeaderTableViewCell = cell as! HeaderTableViewCell
            cell.configureCell(rowObject as! SectionTitleObject)

            break;
        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            let cell: VideoInfoTableViewCell = cell as! VideoInfoTableViewCell
            cell.configureCell(rowObject as! VideoInfoObject)

            break;
        case DetailPageCellIdentifier.VideoDescriptionCellIdentifier:

            let cell: VideoDescriptionTableViewCell = cell as! VideoDescriptionTableViewCell
            cell.configureCell(rowObject as! VideoDescriptonObject)

            break;
        case DetailPageCellIdentifier.VideoStatisticCellIdentifier:

            let cell: VideoStatisticTableViewCell = cell as! VideoStatisticTableViewCell
            cell.configureCell(rowObject as! VideoStatisticObject)

            break;

        case DetailPageCellIdentifier.ChannelInfoCellIdentifier:
            let cell: ChannelInfoTableViewCell = cell as! ChannelInfoTableViewCell
            //            cell.configureCell(rowObject as! VideoInfoObject)
            break;

        case DetailPageCellIdentifier.SuggestionListCellIdentifier:
            let cell: SuggestionVideoInfoTableViewCell = cell as! SuggestionVideoInfoTableViewCell
            cell.configureCell(rowObject as! YoutubeVideoCache)
            break;

        default:
            break;
        }
    }


    //MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section: DetailPageSection = getSectionByIndex(indexPath.section)
        let rowObject: AnyObject = section.rowObjects[indexPath.row]
        let sectionIdentifier: DetailPageCellIdentifier = section.sectionIdentifier!

        switch (sectionIdentifier) {

        case DetailPageCellIdentifier.VideoInfoCellIdentifier:
            self.toggleVideoDesctionAnimation()
            break;
        case DetailPageCellIdentifier.ChannelInfoCellIdentifier:
            break;
        case DetailPageCellIdentifier.SuggestionListCellIdentifier:
            let x = 0
            break;

        default:
            break;
        }

    }

    func toggleVideoDesctionAnimation() {
        //        let section:DetailPageSection = self.pageSections.values[0]

        //        self.tableView.beginUpdates()
        //
        //        let animatedIndexPath = NSIndexPath(forRow: 0, inSection: 1)
        //        if(section.isOpen == true){
        ////            DetailPageSection.removeAnimatedObject(self.pageSections[1], index: 0)
        //            self.tableView.deleteRowsAtIndexPaths([animatedIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        //        }else{
        ////            DetailPageSection.addAnimatedObject(self.pageSections[1], index: 0)
        //            self.tableView.insertRowsAtIndexPaths([animatedIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        //        }
        //
        //        self.tableView.endUpdates()
        //
        //        section.isOpen = !section.isOpen

    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section: DetailPageSection = getSectionByIndex(indexPath.section)
        //        println("rowHeight is \(section.rowHeight)")

        return section.rowHeight
    }


    //    override  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        let section:DetailPageSection = getSectionByIndex(section)
    //
    //        return section.sectionHeaderHeight
    //    }



    //    override  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        let section:DetailPageSection = getSectionByIndex(section)
    //        return section.sectionFooterHeight
    //    }



    func getSectionByIndex(index: Int) -> DetailPageSection {
        let identifier: String = self.sectionKeys[index]

        return watchTableModel.getSectionByIndex(identifier)
    }


}
