//
//  MABYT3_LISTRequest.h
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 5/6/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YouTubeAPI3-Objective-C-wrapper/MABYT3_APIRequest.h>

#import "AFHTTPSessionManager.h"

#define SUBSCRIPTION_LIST_MAX 2

@class YoutubeResponseInfo;

typedef void (^MABYoutubeResponseBlock)(YoutubeResponseInfo *responseInfo, NSError *error);

static NSString *kKeychainItemName = @"mxyoutube";
static NSUInteger search_maxResults = 20;


@interface MABYT3_YoutubeRequest : AFHTTPSessionManager

- (id)commonDictionary:(id)parameters maxResultsString:(NSString *)maxResultsString;

- (NSError *)getError:(NSData *)data httpresp:(NSHTTPURLResponse *)httpresp;
@end


@interface MABYT3_VideoGoogleRequest : MABYT3_YoutubeRequest

@property (nonatomic, strong) NSURLSessionDataTask *lastTask;

+ (MABYT3_VideoGoogleRequest *)sharedInstance;

- (NSURLSessionDataTask *)fetchCaptainTracks:(NSString *)videoId completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)fetchVideoTranscript:(NSString *)videoId  withTrack:(id)track completion:(MABYoutubeResponseBlock)completion;
@end


@interface MABYT3_GetVideoInfoRequest : MABYT3_YoutubeRequest

+ (MABYT3_GetVideoInfoRequest *)sharedInstance;

- (NSURLSessionDataTask *)fetchVideoInfoMetadata:(NSString *)videoId completion:(MABYoutubeResponseBlock)completion;

@end


@interface MABYT3_AutoCompleteRequest : MABYT3_YoutubeRequest

@property (nonatomic, strong) NSURLSessionDataTask *lastTask;

+ (MABYT3_AutoCompleteRequest *)sharedInstance;

- (NSURLSessionDataTask *)autoCompleteSuggestions:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (void)cancelAllTask;

@end


@interface MABYT3_APIRequest : MABYT3_YoutubeRequest
+ (MABYT3_APIRequest *)sharedInstance;


- (NSString *)GuidedCategoriesURLforRegion:(NSString *)reg andLanguage:(NSString *)lang;

- (NSString *)LanguagesURLforLanguae:(NSString *)lang;

- (NSString *)RegionsURLforLanguae:(NSString *)lang;


- (NSURLSessionDataTask *)LISTActivitiesForURLFilterUpload:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion;

- (void)LISTActivitiesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;

- (void)LISTChannelSectionsForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;

- (void)LISTChannelsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;

- (void)LISTGuideCategoriesForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;

- (void)LISTLanguagesForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;

- (void)LISTRegionsForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;

- (NSURLSessionDataTask *)LISTVideosForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)LISTSubscriptionsForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion accessToken:(NSString *)authToken;

- (NSURLSessionDataTask *)LISTChannelsThumbnailsForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)LISTPlayListForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)LISTPlayListItemForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)LISTActivitiesForURL:(id)parameters completion:(MABYoutubeResponseBlock)completion;

- (NSURLSessionDataTask *)searchForParameters:(id)parameters completion:(MABYoutubeResponseBlock)completion;


- (void)LIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler;

- (void)DISLIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler;

- (void)INSERTSubscription:(NSString *)channelId andHandler:(void (^)(NSError *, BOOL))handler;

- (void)INSERTVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler;

- (void)INSERTPlayList:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(id)status andHandler:(void (^)(NSError *, NSString *, BOOL))handler;

- (void)INSERTPlayList:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, NSString *, BOOL))handler;


- (void)UPDATEPlayListItem:(NSString *)itemId withVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler;

- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(id)status andHandler:(void (^)(NSError *, BOOL))handler;

- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, BOOL))handler;


- (void)DELETEPlayListItem:(NSString *)itemId withHandler:(void (^)(NSError *, BOOL))handler;

- (void)DELETEPlayList:(NSString *)playlistID withHandler:(void (^)(NSError *, BOOL))handler;

- (void)DELETESubscription:(NSString *)subscriptionId andHandler:(void (^)(NSError *, BOOL))handler;


@end
