//
//  ALMoviePlayerControls.h
//  ALMoviePlayerController
//
//  Created by Anthony Lobianco on 10/8/13.
//  Copyright (c) 2013 Anthony Lobianco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "ALButton.h"
#import "ALMoviePlayerControlsBase.h"

@protocol ALMoviePlayerControlsDelegate <NSObject>
@optional
- (void)didCancel;
@required
- (void)didChoose;
@end

@class ALMoviePlayerController;



@interface ALMoviePlayerControls : ALMoviePlayerControlsBase

/**
 The color of the control bars. 
 
 Default value is black with a hint of transparency.
 */
@property (nonatomic, strong) UIColor *barColor;

/**
 The amount of time that the controls should stay on screen before automatically hiding.
 
 Default value is 5 seconds.
 */
@property (nonatomic, assign) NSTimeInterval fadeDelay;



/**
 The rate at which the movie should fastforward or rewind.
 
 Default value is 3x.
 */
@property (nonatomic, assign) float seekRate;

/** 
 Should the time-remaining number decrement as the video plays?
 
 Default value is NO.
 */
@property (nonatomic) BOOL timeRemainingDecrements;


@property (nonatomic, weak) id<ALMoviePlayerControlsDelegate> delegate;

- (void)setTwoBars:(UIView *)topBar withBottomBar:(UIView *)bottomBar withDurationSlider:(UISlider *)durationSlider withTimeElapsedLabel:(UILabel *)timeElapsedLabel withTimeRemainingLabel:(UILabel *)timeRemainingLabel withPlayPauseButton:(UIButton *)playPauseButton moviePause:(NSString *)moviePause moviePlay:(NSString *)moviePlay;

/** 
 The default initializer method. The parameter may not be nil.
 */
- (id)initWithMoviePlayer:(ALMoviePlayerController *)moviePlayer style:(ALMoviePlayerControlsStyle)style;

@end