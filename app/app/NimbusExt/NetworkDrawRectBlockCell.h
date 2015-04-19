//
// Created by djzhang on 4/16/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NimbusModels.h"

@class NIAttributedLabel;

// This subclass of NIDrawRectBlockCell simply handles the fetching of an image from the network.
// We use a network image view to do this, but we never add the network image view to the view
// hierarchy because we are going to render the image in the cell block.
@interface NetworkDrawRectBlockCell : NIDrawRectBlockCell


@property (nonatomic, strong) NIAttributedLabel *descriptionLabel;


+ (CGFloat)getBlockCellHeight:(id)object withWidth:(CGFloat)width;
@end