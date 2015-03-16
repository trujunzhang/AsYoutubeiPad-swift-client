//
//  YoutubeAuthInfo.h
//  IOSTemplate
//
//  Created by djzhang on 11/2/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YoutubeAuthInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *thumbnailUrl;

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;

@property (nonatomic, copy) NSString *tokenType;

+ (void)saveAuthAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken;


- (void)readTokens;
@end
