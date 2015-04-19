//
//  VideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class VideoInfoViewController: UIViewController, UITableViewDelegate {

    var model: NITableViewModel?
    var tableView: UITableView?
    var isOpen: Bool = false
    var cellFactory: NICellFactory?

    var videoInfoObject: VideoInfoObject?
    var obj: NIDrawRectBlockCellObject?
    var animateObject: TableAnimateObject?

    var tableContents: [AnyObject] = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)

        makeModel()
        tableView = UITableView()

        self.view.addSubview(tableView!)

        layout(tableView!) {
            view1 in

            view1.leading == view1.superview!.leading + 20
            view1.trailing == view1.superview!.trailing - 20

            view1.top == view1.superview!.top + 20
            view1.bottom == view1.superview!.bottom - 20
        }

        tableView?.dataSource = model
        tableView?.delegate = self

        tableView?.rowHeight = 100

        isOpen = true

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let infoObject: VideoInfoObject = videoInfoObject {
            let specialRowHeight = VideoInfoDrawRectBlockCell.getBlockCellHeight(infoObject, width: 123)

            infoObject.currentRowHeight = specialRowHeight

            animateObject = TableAnimateObject(_maxValue: specialRowHeight)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK : model
    func makeModel() {
        let drawTextBlock: NICellDrawRectBlock = {
            rect, object, cell in


            return 100
        }

        videoInfoObject = VideoInfoObject()
        obj = NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject)
        tableContents = [
                NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
                NITitleCellObject(title: "xcode"),
                NITitleCellObject(title: "wanghao")
        ]

        cellFactory = NICellFactory()
        cellFactory?.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: VideoInfoDrawRectBlockCell.self)

        model = NITableViewModel(listArray: tableContents, delegate: cellFactory)

    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) {
            if let infoObject: VideoInfoObject = videoInfoObject {
                return infoObject.currentRowHeight
            }
        }

        return 200
    }

    func updateAnimatedTableCell() {
        if let _tableView: UITableView = tableView {
            _tableView.beginUpdates()
            let indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            let reloadIndexPath = [indexPath]
            _tableView.reloadSections(reloadIndexPath, withRowAnimation: none)
            _tableView.endUpdates()
        }
    }


}