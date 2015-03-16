//
//  DebugUtils.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "DebugUtils.h"


@implementation DebugUtils

+ (void)printFrameInfo:(CGRect)frame withControllerName:(NSString *)controllerName {
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;

    NSLog([NSString stringWithFormat:@"    %@     ", controllerName]);
    NSLog(@"x = %f", x);
    NSLog(@"y = %f", y);
    NSLog(@"w = %f", w);
    NSLog(@"h = %f", h);
}


+ (void)printCGRect:(CGRect)cellRect {
    NSLog(@"Pretty printed rect: %@", NSStringFromCGRect(cellRect));
}


+ (void)printCGSize:(CGSize)cellSize {
    NSLog(@"Pretty printed size: %@", NSStringFromCGSize(cellSize));
}


+ (void)listAppHomeInfo {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachePath = [cachePathArray lastObject];
    NSLog(@"Cache Directory: %@", cachePath);
#endif
}
@end
