//
//  MPMoviePlayerController+Subtitles.h
//  MPMoviePlayerControllerSubtitles
//
//  Created by mhergon on 03/12/13.
//  Copyright (c) 2013 mhergon. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@class SRTParserInterface;


@interface MPMoviePlayerController (Subtitles)

@property (nonatomic, strong) SRTParserInterface *parserHelper;

#pragma mark - Methods

- (void)openWithSRTString:(NSString *)srtString parserHelper:(SRTParserInterface *)parserHelper completion:(void (^)(BOOL finished))success failure:(void (^)(NSError *error))failure;

- (void)openSRTFileAtPath:(NSString *)localSRTFile parserHelper:(SRTParserInterface *)parserHelper completion:(void (^)(BOOL finished))success failure:(void (^)(NSError *error))failure;

- (void)showSubtitles;

- (void)hideSubtitles;

@end

