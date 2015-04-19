//
//  VideoInfoObject.h
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoInfoObject : NSObject

+ (instancetype)makeVideoInfoObject;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* likeCount;
@property (nonatomic, copy) NSString* descriptionString;
@property (nonatomic) CGFloat currentRowHeight;
@property (nonatomic) BOOL isPortrait;
@property (nonatomic) CGRect showRect;


@end
