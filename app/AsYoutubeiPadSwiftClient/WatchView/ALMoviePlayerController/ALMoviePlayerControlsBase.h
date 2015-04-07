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


@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;

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

- (void)setupTwoBars;
@end
