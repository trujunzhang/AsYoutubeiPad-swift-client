//
//  ALMoviePlayerControlsBase.h
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/7/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALMoviePlayerController;
@class ALButton;

typedef enum {
    /** Controls are not doing anything */
            ALMoviePlayerControlsStateIdle,

    /** Controls are waiting for movie to finish loading */
            ALMoviePlayerControlsStateLoading,

    /** Controls are ready to play and/or playing */
            ALMoviePlayerControlsStateReady,

} ALMoviePlayerControlsState;

typedef enum {
    /** Controls will appear in a bottom bar */
            ALMoviePlayerControlsStyleEmbedded,

    /** Controls will appear in a top bar and bottom bar */
            ALMoviePlayerControlsStyleFullscreen,

    /** Controls will appear as ALMoviePlayerControlsStyleFullscreen when in fullscreen and ALMoviePlayerControlsStyleEmbedded at all other times */
            ALMoviePlayerControlsStyleDefault,

    /** Controls will not appear */
            ALMoviePlayerControlsStyleNone,

} ALMoviePlayerControlsStyle;

@interface ALMoviePlayerControlsBase : UIView


@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UISlider *durationSlider;
@property (nonatomic, strong) ALButton *playPauseButton;

@property (nonatomic, strong) UILabel *timeElapsedLabel;
@property (nonatomic, strong) UILabel *timeRemainingLabel;

@property (nonatomic, strong) ALButton *cancelButton;
@property (nonatomic, strong) ALButton *chooseButton;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;



@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;


/**
The height of the control bars.

Default value is 70.f for iOS7+ and 50.f for previous versions.
*/
@property (nonatomic, assign) CGFloat barHeight;


/**
The state of the controls.
*/
@property (nonatomic, readonly) ALMoviePlayerControlsState state;


/**
The style of the controls. Can be changed on the fly.

Default value is ALMoviePlayerControlsStyleDefault
*/
@property (nonatomic, assign) ALMoviePlayerControlsStyle style;

@property (nonatomic, assign) BOOL neverHide;

/**
Are the controls currently showing on screen?
*/
@property (nonatomic, readonly, getter = isShowing) BOOL showing;


- (void)hideControls:(void (^)(void))completion;

- (void)setTwoBars:(UIView *)topBar withBottomBar:(UIView *)bottomBar withDurationSlider:(UISlider *)durationSlider withTimeElapsedLabel:(UILabel *)timeElapsedLabel withTimeRemainingLabel:(UILabel *)timeRemainingLabel withPlayPauseButton:(ALButton *)playPauseButton moviePause:(NSString *)moviePause moviePlay:(NSString *)moviePlay;

- (void)setupTwoBars:(NSString *)pause withoviePlay:(NSString *)play;
@end
