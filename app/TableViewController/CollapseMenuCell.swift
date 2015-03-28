//
//  CollapseMenuCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class CollapseMenuCell: UITableViewCell {
    
    var featureImageSizeOptional: CGSize?
    var placeholderLayer: CALayer!
    var contentLayer: CALayer?
    var containerNode: ASDisplayNode?
    var nodeConstructionOperation: NSOperation?
    
    var _nodeCellSize:CGSize?
    var _isRemoteImage:Bool?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderLayer = CALayer()
        placeholderLayer.contents = UIImage(named: "cardPlaceholder")!.CGImage
        placeholderLayer.contentsGravity = kCAGravityCenter
        placeholderLayer.contentsScale = UIScreen.mainScreen().scale
        placeholderLayer.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1).CGColor
        contentView.layer.addSublayer(placeholderLayer)
    }
    
    //MARK: Layout
    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(REAR_VIEW_WIDTH, TABLE_ROW_HEIGHT)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        placeholderLayer?.frame = bounds
        CATransaction.commit()
    }
    
    //MARK: Cell Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if let operation = nodeConstructionOperation {
            operation.cancel()
        }
        
        //        containerNode?.setDisplaySuspended(true)
        contentLayer?.removeFromSuperlayer()
        contentLayer = nil
        containerNode = nil
    }
    
    //MARK: Cell Content
    func configureCellDisplayWithCardInfo(title: String, iconUrl: String, isRemoteImage: Bool,
        nodeConstructionQueue: NSOperationQueue)  {
            if let oldNodeConstructionOperation = nodeConstructionOperation {
                oldNodeConstructionOperation.cancel()
            }
            
            let newNodeConstructionOperation = nodeConstructionOperationWithCardInfo(title, iconUrl: iconUrl, isRemoteImage: isRemoteImage)
            nodeConstructionOperation = newNodeConstructionOperation
            nodeConstructionQueue.addOperation(newNodeConstructionOperation)
    }
    
    func nodeConstructionOperationWithCardInfo(title: String, iconUrl: String, isRemoteImage: Bool) -> NSOperation {
        let nodeConstructionOperation = NSBlockOperation()
        nodeConstructionOperation.addExecutionBlock {
            [weak self, unowned nodeConstructionOperation] in
            
            if nodeConstructionOperation.cancelled {
                return
            }
            if let strongSelf = self {
                //MARK: Node Creation Section
                
                var cell:AsMenuTableRowCell = AsMenuTableRowCell(nodeCellSize: CGSizeMake(REAR_VIEW_WIDTH, TABLE_ROW_HEIGHT), title: title, iconUrl: iconUrl, isRemoteImage: isRemoteImage)
                
                //MARK: Container Node Creation Section
                let containerNode = ASDisplayNode()
                containerNode.layerBacked = true
//                containerNode.shouldRasterizeDescendants = true
//                containerNode.borderColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 0.2).CGColor
//                containerNode.borderWidth = 1


                if nodeConstructionOperation.cancelled {
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) { [weak nodeConstructionOperation] in
                    if let strongNodeConstructionOperation = nodeConstructionOperation {
                        if strongNodeConstructionOperation.cancelled {
                            return
                        }
                        if strongSelf.nodeConstructionOperation !== strongNodeConstructionOperation {
                            return
                        }
//                        if containerNode.preventOrCancelDisplay {
//                            return
//                        }
                        //MARK: Node Layer and Wrap Up Section
                        strongSelf.contentView.layer.addSublayer(containerNode.layer)
                        containerNode.setNeedsDisplay()
                        strongSelf.contentLayer = containerNode.layer
                        strongSelf.containerNode = containerNode
                    }
                }
            }
        }
        return nodeConstructionOperation
    }
    
}
