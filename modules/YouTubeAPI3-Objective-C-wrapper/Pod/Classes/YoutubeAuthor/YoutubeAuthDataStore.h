//
//  YoutubeAuthDataStore.h
//  IOSTemplate
//
//  Created by djzhang on 11/2/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YoutubeAuthInfo;


@interface YoutubeAuthDataStore : NSObject

+ (void)resetAuthToken;

+ (YoutubeAuthInfo *)saveAuthAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken;

+ (YoutubeAuthInfo *)readTokens;

- (void)resetAuthUserChannel;

- (YoutubeAuthInfo *)readAuthUserInfo;

- (YoutubeAuthInfo *)saveAuthUserChannelWithTitle:(NSString *)title withEmail:(NSString *)email withThumbmailUrl:(NSString *)thumbnailUrl;


@end
