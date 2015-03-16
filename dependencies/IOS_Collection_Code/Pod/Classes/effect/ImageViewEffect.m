//
//  ImageViewEffect.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "ImageViewEffect.h"


@implementation ImageViewEffect


+ (void)setEffectImage:(UIImageView *)imageView withCornerRadius:(CGFloat)cornerRadius {
    imageView.layer.masksToBounds = YES;
//   imageView.layer.cornerRadius = 50.0;
    imageView.layer.cornerRadius = cornerRadius;
//   imageView.layer.borderColor = [UIColor clearColor].CGColor;
//   imageView.layer.borderWidth = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
}
@end
