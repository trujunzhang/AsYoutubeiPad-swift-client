//
//  MAB_GoogleUserCredentials.h
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 4/30/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAB_GoogleAccessToken.h"
#import "MABYT3_Channel.h"
#import "MABYT3_Subscription.h"


#define IsPad      (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma message "You have to register your app at https://console.developers.google.com/ to get ClientID, Client secret & apiKey"


static NSString *apiKey = @"AIzaSyBd9kf5LB41bYWnxI3pfoxHJ2njRvmAA90";
static NSString *kMyClientID = @"632947002586-hsu569tme6lt8635vvoofi5mnkqfkqus.apps.googleusercontent.com";
static NSString *kMyClientSecret = @"dHWxjaetid5ckoVMzp0LmzJt";
static NSString *scope = @"https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload";
//static NSString * scope = @"https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload https://www.googleapis.com/auth/userinfo.email";


@protocol MAB_GoogleUserCredentialsDelegate<NSObject>

- (void)CredUserNoChannel;

- (void)CredUserUpdated;

- (void)CredUserPrepare;

- (void)CredUserSubsComplete;

@optional
- (void)ChooseChannel:(NSMutableArray *)channels;

@end


@interface MAB_GoogleUserCredentials : NSObject {
    BOOL userFetched;
    NSString *nxtSubURL;
}

@property (nonatomic) BOOL signedin;
@property (strong, nonatomic) MAB_GoogleAccessToken *token;
@property (strong, nonatomic) MABYT3_Channel *user;
@property (strong, nonatomic) NSMutableArray *ytSubs;
@property (weak, nonatomic) id<MAB_GoogleUserCredentialsDelegate> delegate;


+ (MAB_GoogleUserCredentials *)sharedInstance;

- (void)saveToken;

- (void)initUser;

- (void)SignOut;

- (void)saveToken:(MAB_GoogleAccessToken *)token;

- (void)setAuthToken:(MAB_GoogleAccessToken *)token isSignedIn:(BOOL)in;
@end
