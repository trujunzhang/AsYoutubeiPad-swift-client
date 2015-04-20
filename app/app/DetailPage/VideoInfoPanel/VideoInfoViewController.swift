//
//  VideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class VideoInfoViewController: UIViewController, UITableViewDelegate, VideoInfoToggleProtocol {

    var model: NITableViewModel?
    var tableView: UITableView?
    var isOpen: Bool = false
    var cellFactory: NICellFactory?

    var videoInfoObject: VideoInfoObject?
    var obj: NIDrawRectBlockCellObject?

    var tableContents: [AnyObject] = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgba: VIDEO_INFO_BACKGROUND_COLOR)

        makeModel()

        tableView = UITableView()

        self.view.addSubview(tableView!)

        layout(tableView!) {
            view1 in

            view1.leading == view1.superview!.leading + VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT
            view1.trailing == view1.superview!.trailing - VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT

            view1.top == view1.superview!.top + 20 + 100
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
            infoObject.videoInfoToggleProtocol = self
            let viewWidth = self.view.frame.size.width - (VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT * 2)
            //            println("viewWidth : \(viewWidth)")

            let specialRowHeight: CGFloat = VideoInfoDrawRectBlockCell.getBlockCellHeight(infoObject, width: viewWidth)
            //            println("specialRowHeight : \(specialRowHeight)")

            infoObject.setDescriptionMaxHeight(specialRowHeight, _descriptionWidth: viewWidth)
        }
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
                NIDrawRectBlockCellObject(block: drawTextBlock, object: videoInfoObject),
                NITitleCellObject(title: "toggle"),
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
                let height = infoObject.currentRowHeight + VIDEO_INFO_TITLE_PANEL_HEIGHT
                println("tablerow's height: \(height)")
                return height
            }
        }

        return 200
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
//            performAnimation()
        }
    }

    // MARK: tableview events

    func updateAnimatedTableCell() {
        if let _tableView: UITableView = tableView {
            _tableView.beginUpdates()
            let indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            let reloadIndexPath = [indexPath]
            _tableView.reloadRowsAtIndexPaths(reloadIndexPath, withRowAnimation: .None)
            _tableView.endUpdates()
        }
    }

    @IBAction func xxx(sender: AnyObject) {
        performAnimation()
    }

    // MARK: Video Info tableview cell's animate
    func performAnimation() {
        videoInfoObject?.prepareAnimate(isOpen)

        var toValue: CGFloat = 0
        if (isOpen == true) {
            toValue = 0
        } else {
            toValue = videoInfoObject!.maxHeightValue
        }


        let spring: POPBasicAnimation = POPBasicAnimation()
        var name = kCAMediaTimingFunctionEaseOut
        if (isOpen == true) {
            name = kCAMediaTimingFunctionEaseIn
        }
        spring.timingFunction = CAMediaTimingFunction(name: name)
        spring.completionBlock = {
            (anim, finished) -> Void in

            self.videoInfoObject!.currentRowHeight = toValue

            self.updateAnimatedTableCell()

            let x = 0
        }

        let property: POPAnimatableProperty = POPAnimatableProperty.propertyWithName("com.rwt.heightContstraint", initializer: {
            (object) -> Void in

            let prop: POPMutableAnimatableProperty = object as POPMutableAnimatableProperty

            // note the object used is NSLayoutConstraint, the same object we assign the animation to
            prop.readBlock = {
                (anyObject, values) -> Void in

                if let object: VideoInfoObject = anyObject as? VideoInfoObject {
                    values[0] = object.fromValue!
                }

            }

            prop.writeBlock = {
                (anyObject, values) -> Void in

                if let object: VideoInfoObject = anyObject as? VideoInfoObject {
                    object.fromValue = values[0]
                    self.videoInfoObject!.currentRowHeight = values[0]

                    self.updateAnimatedTableCell()
                }

            }


            // this helps Pop determine when the animation is over
            prop.threshold = 0.01

        }) as! POPAnimatableProperty

        spring.property = property
        spring.toValue = toValue

        isOpen = !isOpen

        videoInfoObject!.pop_addAnimation(spring, forKey: "TableRowAnimate")

    }

    // MARK : VideoInfoToggleProtocol
    func toggleVideoInfoPanel() -> Void {

    }


}