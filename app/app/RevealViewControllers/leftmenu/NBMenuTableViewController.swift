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

class NBMenuTableViewController: UIViewController, UITableViewDelegate {

    var model: NIMutableTableViewModel?
    var tableView: UITableView?
    var cellFactory: NICellFactory?

    var videoInfoObject: VideoInfoObject?
    var obj: NIDrawRectBlockCellObject?

    var tableContents: [AnyObject] = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)


        makeModel()

        tableView = UITableView()

        if let theTableView: UITableView = tableView {
            theTableView.backgroundColor = UIColor.blackColor()
            theTableView.separatorStyle = .None

            self.view.addSubview(theTableView)

            theTableView.dataSource = model
            theTableView.delegate = self

            layout(theTableView) {
                view1 in

                view1.leading == view1.superview!.leading

                view1.top == view1.superview!.top
                view1.bottom == view1.superview!.bottom

                view1.width == LEFT_MENU_WIDTH
            }

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
        let cellObject: YTCategoryCellObject = YTCategoryCellObject(title: "", image: UIImage(named: "Film.png")!, userInfo: obj!)
        //        YTCategoryCellObject(title: "", image: UIImage(named: ""), userInfo: nil)
        //        YTCategoryCellObject(title: "toggle", image: UIImage(named: "Film.png"), userInfo: nil)

        tableContents = [
                //            "wanghao",
                //                NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
                NITitleCellObject(title: "wanghao"),
                YTCategoryCellObject(title: "Category", image: UIImage(named: "Film.png")!, userInfo: obj!),
                YTCategoryCellObject(title: "djzhang", image: UIImage(named: "Film.png")!, userInfo: obj!),
                //                YTCategoryCellObject(title:  "toggle", image: UIImage(named: "Film.png"),userInfo: nil),
                //                NITitleCellObject(title: "xcode")
        ]

        cellFactory = NICellFactory()

        if let theCellFactory: NICellFactory = cellFactory {
            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)
        }

        model = NIMutableTableViewModel(listArray: tableContents, delegate: cellFactory)

        // We are going to show how to recompile the section index so we provide the settings here.
        model!.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch: false, showsSummary: false)

        //        let indexSet: NSIndexSet = model!.insertSectionWithTitle("wanghao", atIndex: 0)
        //        tableView?.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            //            performAnimation()
        }
    }


}