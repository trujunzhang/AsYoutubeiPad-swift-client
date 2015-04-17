//
// Created by djzhang on 4/16/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NimbusNetworkImage.h"
#import "NimbusModels.h"

// This subclass of NIDrawRectBlockCell simply handles the fetching of an image from the network.
// We use a network image view to do this, but we never add the network image view to the view
// hierarchy because we are going to render the image in the cell block.
@interface NetworkDrawRectBlockCell : NIDrawRectBlockCell<NINetworkImageViewDelegate>
@property (nonatomic, retain) NINetworkImageView *networkImageView;
@end