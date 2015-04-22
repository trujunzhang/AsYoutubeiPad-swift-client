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
        tableView!.backgroundColor = UIColor.blackColor()

        self.view.addSubview(tableView!)

        layout(tableView!) {
            view1 in

            view1.leading == view1.superview!.leading

            view1.top == view1.superview!.top
            view1.bottom == view1.superview!.bottom

            view1.width == LEFT_MENU_WIDTH
        }

        tableView?.dataSource = model
        tableView?.delegate = self
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
        tableContents = [
//            "wanghao",
//                NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
                NITitleCellObject(title: "wanghao"),
                NITitleCellObject(title: "toggle", image: UIImage(named: "Film.png")),
                NITitleCellObject(title: "xcode")
        ]

        cellFactory = NICellFactory()
        cellFactory?.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)

        model = NIMutableTableViewModel(listArray: tableContents, delegate: cellFactory)

        // We are going to show how to recompile the section index so we provide the settings here.
//        [_model setSectionIndexType:NITableViewModelSectionIndexDynamic showsSearch:NO showsSummary:NO];
        model!.setSectionIndexType(NITableViewModelSectionIndexDynamic, showsSearch:false, showsSummary:false)



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