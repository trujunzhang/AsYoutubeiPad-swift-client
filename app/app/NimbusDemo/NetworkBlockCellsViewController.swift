//
//  NetworkBlockCellsViewController.swift
//  app
//
//  Created by djzhang on 4/16/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class NetworkBlockCellsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var drawTextBlock: NICellDrawRectBlock?
    var tableContents: [AnyObject] = [AnyObject]()
    var cellFactory: NICellFactory?
    var model: NITableViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        makeModel()

        tableView.dataSource = model
    }

    func makeModel() {
        var drawTextBlock: NICellDrawRectBlock = {
            (rect, _object, _cell) -> CGFloat in

            if let cell: UITableViewCell = _cell {

                if (cell.highlighted || cell.selected) {
                    UIColor.clearColor().set()
                } else {
                    UIColor.whiteColor().set()
                }
            }
            UIRectFill(rect)

            let text: NSString = (_object as? NSString)!

            UIColor.blackColor().set()
            let titleFont: UIFont = UIFont.boldSystemFontOfSize(16)
            let titleWidth: CGFloat = rect.size.width - 400

//            let size:CGSize =
//            text.
            text.sizeWithAttributes([NSFontAttributeName:titleFont])

//            CGSize size = [text sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//            if(nil != cell) {
//                [text drawInRect:CGRectMake(10, 5, size.width, size.height) withFont:titleFont lineBreakMode:NSLineBreakByWordWrapping];
//            }


            let ret: CGFloat = 1.0
            return ret

        }


        var tableContents: [AnyObject] = [
                NIDrawRectBlockCellObject.objectWithBlock(drawTextBlock, object: "wanghao")
        ]

        cellFactory = NICellFactory()
        if let factory: NICellFactory = cellFactory {
            factory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: NetworkDrawRectBlockCell.self)

            model = NITableViewModel(listArray: tableContents, delegate: factory)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK : UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 0
    }

}