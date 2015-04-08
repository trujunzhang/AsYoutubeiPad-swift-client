//
//  MPMoviePlayerController+Subtitles.m
//  MPMoviePlayerControllerSubtitles
//
//  Created by mhergon on 03/12/13.
//  Copyright (c) 2013 mhergon. All rights reserved.
//

#import "MPMoviePlayerController+Subtitles.h"
#import "SRTParserInterface.h"
#import <objc/runtime.h>


@interface MPMoviePlayerViewController ()

#pragma mark - Properties
@property (strong, nonatomic) NSMutableDictionary *subtitlesParts;
@property (strong, nonatomic) NSTimer *subtitleTimer;
@property (strong, nonatomic) UILabel *subtitleLabel;

#pragma mark - Private methods

- (void)showSubtitles:(BOOL)show;

- (void)parseString:(NSString *)string parsed:(void (^)(BOOL parsed, NSError *error))completion;

- (NSTimeInterval)timeFromString:(NSString *)yimeString;

- (void)searchAndShowSubtitle;

#pragma mark - Notifications

- (void)playbackStateDidChange:(NSNotification *)notification;

- (void)playbackDidFinish:(NSNotification *)notification;

- (void)orientationWillChange:(NSNotification *)notification;

- (void)orientationDidChange:(NSNotification *)notification;


@end


@implementation MPMoviePlayerController (Subtitles)

#pragma mark - Methods


- (void)openSRTFileAtPath:(NSString *)localSRTFile parserHelper:(SRTParserInterface *)parserHelper completion:(void (^)(BOOL finished))success failure:(void (^)(NSError *error))failure {

    // Error
    NSError *error = nil;


    // File to string
    NSString *subtitleString = [NSString stringWithContentsOfFile:localSRTFile
                                                         encoding:NSUTF8StringEncoding
                                                            error:&error];
    if(error && failure != NULL) {
        failure(error);
        return;
    }

    // Parse and show text
    [self openWithSRTString:subtitleString parserHelper:parserHelper completion:success failure:failure];


}


- (void)openWithSRTString:(NSString *)srtString parserHelper:(SRTParserInterface *)parserHelper completion:(void (^)(BOOL finished))success failure:(void (^)(NSError *error))failure {

    [self parseString:srtString parserHelper:parserHelper parsed:^(BOOL parsed, NSError *error) {

        if(!error && success != NULL) {

            // Register for notifications
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playbackStateDidChange:)
                                                         name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                       object:nil];

            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(orientationWillChange:)
                                                         name:UIApplicationWillChangeStatusBarFrameNotification
                                                       object:nil];

            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(orientationDidChange:)
                                                         name:UIDeviceOrientationDidChangeNotification
                                                       object:nil];

            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playbackDidFinish:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:nil];

            if(success != NULL) {
                success(YES);
            }

        } else if(error && failure != NULL) {

            if(failure != NULL) {
                failure(error);
            }

        }

    }];

}


- (void)showSubtitles:(BOOL)show {

    // Hide label
    self.subtitleLabel.hidden = !show;

}


- (void)showSubtitles {

    [self showSubtitles:YES];

}


- (void)hideSubtitles {

    [self showSubtitles:NO];

}


#pragma mark - Private methods


- (void)parseString:(NSString *)string parserHelper:(SRTParserInterface *)parserHelper parsed:(void (^)(BOOL parsed, NSError *error))completion {
    // Subtitles parts
    self.subtitlesParts = [NSMutableDictionary dictionary];

    [parserHelper parseSRTString:string
                    toDictionary:self.subtitlesParts
                          parsed:completion];
}


- (void)searchAndShowSubtitle {

    // Search for timeInterval
    NSPredicate *initialPredicate = [NSPredicate predicateWithFormat:@"(%@ >= %K) AND (%@ <= %K)",
                                                                     @(self.currentPlaybackTime),
                                                                     kStart,
                                                                     @(self.currentPlaybackTime),
                                                                     kEnd];
    NSArray *objectsFound = [[self.subtitlesParts allValues] filteredArrayUsingPredicate:initialPredicate];
    NSDictionary *lastFounded = (NSDictionary *)[objectsFound lastObject];

    // Show text
    if(lastFounded) {

        // Get text
        self.subtitleLabel.text = [lastFounded objectForKey:kText];


        // Label position
        CGSize size = [self.subtitleLabel.text sizeWithFont:self.subtitleLabel.font
                                          constrainedToSize:CGSizeMake(CGRectGetWidth(self.subtitleLabel.bounds), CGFLOAT_MAX)];
        self.subtitleLabel.frame = ({
            CGRect frame = self.subtitleLabel.frame;
            frame.size.height = size.height;
            frame;
        });
        self.subtitleLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0, CGRectGetHeight(self.view.bounds) - (CGRectGetHeight(self.subtitleLabel.bounds) / 2.0) - 15.0);

    } else {

        self.subtitleLabel.text = @"";

    }

}


#pragma mark - Notifications


- (void)playbackStateDidChange:(NSNotification *)notification {

    switch (self.playbackState) {

        case MPMoviePlaybackStateStopped: {

            // Stop
            if(self.subtitleTimer.isValid) {
                [self.subtitleTimer invalidate];
            }

            break;
        }

        case MPMoviePlaybackStatePlaying: {

            // Start timer
            self.subtitleTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                  target:self
                                                                selector:@selector(searchAndShowSubtitle)
                                                                userInfo:nil
                                                                 repeats:YES];
            [self.subtitleTimer fire];


            // Add label
            if(!self.subtitleLabel) {

                // Add label
                CGFloat fontSize = 0.0;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    fontSize = 40.0;
                } else {
                    fontSize = 20.0;
                }
                self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds) - 30.0, 100.0)];
                self.subtitleLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0, CGRectGetHeight(self.view.bounds) - (CGRectGetHeight(self.subtitleLabel.bounds) / 2.0) - 15.0);
                self.subtitleLabel.backgroundColor = [UIColor clearColor];
                self.subtitleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
                self.subtitleLabel.textColor = [UIColor whiteColor];
                self.subtitleLabel.numberOfLines = 0;
                self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
                self.subtitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
                self.subtitleLabel.layer.shadowOffset = CGSizeMake(6.0, 6.0);
                self.subtitleLabel.layer.shadowOpacity = 0.9;
                self.subtitleLabel.layer.shadowRadius = 4.0;
                self.subtitleLabel.layer.shouldRasterize = YES;
                self.subtitleLabel.layer.rasterizationScale = [[UIScreen mainScreen] scale];
                [self.view addSubview:self.subtitleLabel];

            }

            break;
        }

        default: {

            break;
        }

    }

}


- (void)playbackDidFinish:(NSNotification *)notification {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)orientationWillChange:(NSNotification *)notification {

    // Hidden label
    self.subtitleLabel.hidden = YES;

}


- (void)orientationDidChange:(NSNotification *)notification {

    // Label position
    CGSize size = [self.subtitleLabel.text sizeWithFont:self.subtitleLabel.font
                                      constrainedToSize:CGSizeMake(CGRectGetWidth(self.subtitleLabel.bounds), CGFLOAT_MAX)];
    self.subtitleLabel.frame = ({
        CGRect frame = self.subtitleLabel.frame;
        frame.size.height = size.height;
        frame;
    });
    self.subtitleLabel.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0, CGRectGetHeight(self.view.bounds) - (CGRectGetHeight(self.subtitleLabel.bounds) / 2.0) - 15.0);

    // Hidden label
    self.subtitleLabel.hidden = NO;

}


#pragma mark - Others


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)setSubtitlesParts:(NSMutableDictionary *)subtitlesParts {

    objc_setAssociatedObject(self, @"subtitlesParts", subtitlesParts, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (NSMutableDictionary *)subtitlesParts {

    return objc_getAssociatedObject(self, @"subtitlesParts");

}


- (void)setSubtitleTimer:(NSTimer *)timer {

    objc_setAssociatedObject(self, @"timer", timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (NSTimer *)subtitleTimer {

    return objc_getAssociatedObject(self, @"timer");

}


- (void)setSubtitleLabel:(UILabel *)subtitleLabel {

    objc_setAssociatedObject(self, @"subtitleLabel", subtitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (UILabel *)subtitleLabel {

    return objc_getAssociatedObject(self, @"subtitleLabel");

}


@end
