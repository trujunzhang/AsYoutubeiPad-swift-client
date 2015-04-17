//
// Created by djzhang on 4/16/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NimbusNetworkImage.h"
#import "NimbusModels.h"
#import "NetworkDrawRectBlockCell.h"


@implementation NetworkDrawRectBlockCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    _networkImageView = [[NINetworkImageView alloc] init];

    // We implement the delegate so that we know when the image has finished downloading.
    _networkImageView.delegate = self;
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];

  // This resets the networkImageView's .image to the initial image (in this case nil). Oftentimes
  // the initial image will be a local "empty" avatar image that you've provided with your
  // application.
  [self.networkImageView prepareForReuse];
}

- (BOOL)shouldUpdateCellWithObject:(NIDrawRectBlockCellObject *)object {
  [super shouldUpdateCellWithObject:object];

  // Fetch the avatar from the network.
  NSString* gravatarUrl = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=140", object.object];
  // NINetworkImageView is smart enough to know that if we want to display an image at size 70x70
  // on a retina display then it will crop the image to 140x140 and set the image scale to 2.
  CGFloat imageSize = 70;

  // We explicitly set the display size of the network image so that when it is downloaded it gets
  // cropped and resized accordingly. In this case we're fetching a 140x140 image from gravatar
  // so there will be little work to do on retina displays, but older devices will need to resize
  // the image to 70x70.
  [self.networkImageView setPathToNetworkImage:gravatarUrl forDisplaySize:CGSizeMake(imageSize, imageSize)];

  return YES;
}

#pragma mark - NINetworkImageViewDelegate

- (void)networkImageView:(NINetworkImageView *)imageView didLoadImage:(UIImage *)image {
  // Once the image has been downloaded we need to redraw the block.
  [self.blockView setNeedsDisplay];
}

@end