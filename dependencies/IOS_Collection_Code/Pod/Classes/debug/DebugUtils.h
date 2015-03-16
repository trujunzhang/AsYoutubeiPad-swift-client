//
//  DebugUtils.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DebugUtils : NSObject

+ (void)printFrameInfo:(CGRect)frame withControllerName:(NSString *)controllerName;

+ (void)printCGRect:(CGRect)cellRect;

+ (void)printCGSize:(CGSize)cellSize;

+ (void)listAppHomeInfo;
@end
