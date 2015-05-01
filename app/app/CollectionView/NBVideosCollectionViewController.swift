//
//  NBVideosCollectionViewController.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Cartography

class NBVideosCollectionViewController: UICollectionViewController, NICollectionViewModelDelegate {
    var model: NIMutableCollectionViewModel?

    var cellFactory: NICollectionViewCellFactory?

    var requestInfo = YTYoutubeRequestInfo()


    func makeRequestTask() {
        requestInfo = YoutubeFetcher.prepareRequestSearch("Sketch 3", completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray
                var length = array.count

                // Then reload tableview
                self.createSections(array)
            }
        })
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // create NICellFactory instance
        self.makeRequestTask()
        self.makeCollectionView()

        cellFactory = NICollectionViewCellFactory()

        if let theCellFactory: NICollectionViewCellFactory = cellFactory {
            theCellFactory.mapObjectClass(NBVideoCollectionViewCellObject.self, toCellClass: NBVideoCollectionViewCell.self)
            //            theCellFactory.mapObjectClass(NIDrawRectBlockCellObject.self, toCellClass: MenuTitleBarCellObject.self)
        }
    }

    func makeCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(214, 200)
//        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)

        if let theCollectionView: UICollectionView = collectionView {
            theCollectionView.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
            theCollectionView.backgroundColor = UIColor.clearColor()
            theCollectionView.collectionViewLayout = flowLayout
//            self.view.addSubview(theCollectionView)
//            LayoutUtils.LayoutFullView(theCollectionView)
        }

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK : model
    func makeModel(collectionContents: [AnyObject]) -> NIMutableCollectionViewModel {
//        let model: NIMutableCollectionViewModel = NIMutableCollectionViewModel(listArray: collectionContents, delegate: cellFactory)
        let model: NIMutableCollectionViewModel = NimbusCollectionsUtils.makeNIMutableCollectionViewModel(collectionContents)


        return model
    }

    // MARK: refresh collection

    func createSections(array: NSArray) {
        self.requestInfo.appendArray(array)

        let collectionContents: [AnyObject] = NBCollectionSectionGenerator.generatorSections(array)
        model = makeModel(collectionContents)

        reloadCollectionView(model!)
    }

    func reloadCollectionView(model: NIMutableCollectionViewModel) {
        if let theCollectionView: UICollectionView = collectionView {
            theCollectionView.dataSource = model
            theCollectionView.reloadData()
        }
    }

    // MARK: NICollectionViewModelDelegate
    func collectionViewModel(collectionViewModel: NICollectionViewModel!, cellForCollectionView collectionView: UICollectionView!, atIndexPath indexPath: NSIndexPath!, withObject object: AnyObject!) -> UICollectionViewCell! {

        return NICollectionViewCellFactory.collectionViewModel(collectionViewModel, cellForCollectionView: collectionView, atIndexPath: indexPath, withObject: object)

//                + (UICollectionViewCell *)collectionViewModel:(NICollectionViewModel *)collectionViewModel cellForCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
//        return [NICellFactory tableViewModel:tableViewModel cellForTableView:tableView atIndexPath:indexPath withObject:object];
    }

}