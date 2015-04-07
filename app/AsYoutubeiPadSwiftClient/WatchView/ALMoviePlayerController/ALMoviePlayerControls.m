//
//  ALMoviePlayerControls.m
//  ALMoviePlayerController
//
//  Created by Anthony Lobianco on 10/8/13.
//  Copyright (c) 2013 Anthony Lobianco. All rights reserved.
//

#import "ALMoviePlayerControls.h"
#import "ALMoviePlayerController.h"
#import <tgmath.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIDevice (ALSystemVersion)

+ (float)iOSVersion {
    static float version = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return version;
}

@end

@interface ALMoviePlayerControlsBar : UIView

@property (nonatomic, strong) UIColor *color;

@end

@interface ALMoviePlayerControls () <ALButtonDelegate> {
@private
    int windowSubviews;
}


@property (nonatomic, assign) ALMoviePlayerControlsState state;
@property (nonatomic, getter = isShowing) BOOL showing;

@property (nonatomic, strong) NSTimer *durationTimer;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;


@end

@implementation ALMoviePlayerControls

# pragma mark - Construct/Destruct

- (id)initWithMoviePlayer:(ALMoviePlayerController *)moviePlayer style:(ALMoviePlayerControlsStyle)style {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.moviePlayer = moviePlayer;
        self.style = style;
        self.showing = NO;
        self.fadeDelay = 5.0;
        self.timeRemainingDecrements = NO;
        self.barColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        //in fullscreen mode, move controls away from top status bar and bottom screen bezel. I think the iOS7 control center gestures interfere with the uibutton touch events. this will alleviate that a little (correct me if I'm wrong and/or adjust if necessary).
        _barHeight = [UIDevice iOSVersion] >= 7.0 ? 70.f : 50.f;
        
        _seekRate = 3.f;
        _state = ALMoviePlayerControlsStateIdle;
        
        [self setup];
        [self addNotifications];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_durationTimer invalidate];
    [self nilDelegates];
}

# pragma mark - Construct/Destruct Helpers

- (void)setup {
    if (self.style == ALMoviePlayerControlsStyleNone)
        return;

    [self setupTwoBars];

    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.alpha = 0.f;
    _activityIndicator.hidesWhenStopped = YES;
}


- (void)resetViews {
    [self stopDurationTimer];
    [self nilDelegates];
    [_activityIndicator removeFromSuperview];
    [self.topBar removeFromSuperview];
    [self.bottomBar removeFromSuperview];
}

- (void)nilDelegates {
    self.playPauseButton.delegate = nil;
    self.cancelButton.delegate = nil;
    self.chooseButton.delegate = nil;
}

# pragma mark - Setters

- (void)setState:(ALMoviePlayerControlsState)state {
    if (_state != state) {
        _state = state;
        
        switch (state) {
            case ALMoviePlayerControlsStateLoading:
                [self showLoadingIndicators];
                break;
            case ALMoviePlayerControlsStateReady:
                [self hideLoadingIndicators];
                break;
            case ALMoviePlayerControlsStateIdle:
            default:
                break;
        }
    }
}

- (void)setBarColor:(UIColor *)barColor {
    if (_barColor != barColor) {
        _barColor = barColor;
//        [self.topBar setColor:barColor];
//        [self.bottomBar setColor:barColor];
    }
}

# pragma mark - UIControl/Touch Events

- (void)durationSliderTouchBegan:(UISlider *)slider {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControls:) object:nil];
    [self.moviePlayer pause];
}

- (void)durationSliderTouchEnded:(UISlider *)slider {
    [self.moviePlayer setCurrentPlaybackTime:floor(slider.value)];
    [self.moviePlayer play];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
}

- (void)durationSliderValueChanged:(UISlider *)slider {
    double currentTime = floor(slider.value);
    double totalTime = floor(self.moviePlayer.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

- (void)buttonTouchedDown:(UIButton *)button {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControls:) object:nil];
}

- (void)buttonTouchedUpOutside:(UIButton *)button {
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
}

- (void)buttonTouchCancelled:(UIButton *)button {
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:@"layer.sublayers"]) {
        return;
    }
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow) {
        keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    if (keyWindow.layer.sublayers.count == windowSubviews) {
        [keyWindow removeObserver:self forKeyPath:@"layer.sublayers"];
        [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
    }
}

- (void)playPausePressed:(UIButton *)button {
    self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying ? [self.moviePlayer pause] : [self.moviePlayer play];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
}

- (void)choosePressed:(UIButton *)button {
    
    [self.moviePlayer pause];
    
    if ([self.delegate respondsToSelector:@selector(didChoose)]) {
        [self.delegate didChoose];
    }
}



- (void)cancelPressed:(UIButton *)button {
    
    [self.moviePlayer pause];
    
    if ([self.delegate respondsToSelector:@selector(didCancel)]) {
        [self.delegate didCancel];
    }
}

# pragma mark - Notifications

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieContentURLDidChange:) name:ALMoviePlayerContentURLDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDurationAvailable:) name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)movieFinished:(NSNotification *)note {
    self.playPauseButton.selected = YES;
    [self.durationTimer invalidate];
    [self.moviePlayer setCurrentPlaybackTime:0.0];
    [self monitorMoviePlayback]; //reset values
    self.state = ALMoviePlayerControlsStateIdle;
}

- (void)movieLoadStateDidChange:(NSNotification *)note {
    switch (self.moviePlayer.loadState) {
        case MPMovieLoadStatePlayable:
        case MPMovieLoadStatePlaythroughOK:
            [self showControls:nil];
            self.state = ALMoviePlayerControlsStateReady;
            break;
        case MPMovieLoadStateStalled:
        case MPMovieLoadStateUnknown:
            break;
        default:
            break;
    }
}

- (void)moviePlaybackStateDidChange:(NSNotification *)note {
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            self.playPauseButton.selected = NO;
            [self startDurationTimer];
            
            //local file
            if ([self.moviePlayer.contentURL.scheme isEqualToString:@"file"]) {
                [self setDurationSliderMaxMinValues];
                [self showControls:nil];
            }
        case MPMoviePlaybackStateSeekingBackward:
        case MPMoviePlaybackStateSeekingForward:
            self.state = ALMoviePlayerControlsStateReady;
            break;
        case MPMoviePlaybackStateInterrupted:
            self.state = ALMoviePlayerControlsStateLoading;
            break;
        case MPMoviePlaybackStatePaused:
        case MPMoviePlaybackStateStopped:
            self.state = ALMoviePlayerControlsStateIdle;
            self.playPauseButton.selected = YES;
            [self stopDurationTimer];
            break;
        default:
            break;
    }
}

- (void)movieDurationAvailable:(NSNotification *)note {
    [self setDurationSliderMaxMinValues];
}

- (void)movieContentURLDidChange:(NSNotification *)note {
    [self hideControls:^{
        //don't show loading indicator for local files
        self.state = [self.moviePlayer.contentURL.scheme isEqualToString:@"file"] ? ALMoviePlayerControlsStateReady : ALMoviePlayerControlsStateLoading;
    }];
}

# pragma mark - Internal Methods

- (void)startDurationTimer {
    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(monitorMoviePlayback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
}

- (void)stopDurationTimer {
    [self.durationTimer invalidate];
}

- (void)showControls:(void(^)(void))completion {
    if (!self.isShowing) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControls:) object:nil];
        if (self.style == ALMoviePlayerControlsStyleFullscreen || (self.style == ALMoviePlayerControlsStyleDefault && self.moviePlayer.isFullscreen)) {
            [self.topBar setNeedsDisplay];
        }
        [self.bottomBar setNeedsDisplay];
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            if (self.style == ALMoviePlayerControlsStyleFullscreen || (self.style == ALMoviePlayerControlsStyleDefault && self.moviePlayer.isFullscreen)) {
                self.topBar.alpha = 1.f;
            }
            self.bottomBar.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.showing = YES;
            if (completion)
                completion();
            [self performSelector:@selector(hideControls:) withObject:nil afterDelay:self.fadeDelay];
        }];
    } else {
        if (completion)
            completion();
    }
}

- (void)hideControls:(void(^)(void))completion {

    self.neverHide = YES;

    if (self.isShowing && !self.neverHide) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControls:) object:nil];
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            if (self.style == ALMoviePlayerControlsStyleFullscreen || (self.style == ALMoviePlayerControlsStyleDefault && self.moviePlayer.isFullscreen)) {
                self.topBar.alpha = 0.f;
            }
            self.bottomBar.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.showing = NO;
            if (completion)
                completion();
        }];
    } else {
        if (completion)
            completion();
    }
}

- (void)showLoadingIndicators {
    [self addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    [UIView animateWithDuration:0.2f animations:^{
        _activityIndicator.alpha = 1.f;
    }];
}

- (void)hideLoadingIndicators {
    [UIView animateWithDuration:0.2f delay:0.0 options:0 animations:^{
        self.activityIndicator.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.activityIndicator removeFromSuperview];
    }];
}

- (void)setDurationSliderMaxMinValues {
    CGFloat duration = self.moviePlayer.duration;
    self.durationSlider.minimumValue = 0.f;
    self.durationSlider.maximumValue = duration;
}

- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    self.timeElapsedLabel.text = [NSString stringWithFormat:@"%.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining;
    double secondsRemaining;
    if (self.timeRemainingDecrements) {
        minutesRemaining = floor((totalTime - currentTime) / 60.0);
        secondsRemaining = fmod((totalTime - currentTime), 60.0);
    } else {
        minutesRemaining = floor(totalTime / 60.0);
        secondsRemaining = floor(fmod(totalTime, 60.0));
    }
    self.timeRemainingLabel.text = self.timeRemainingDecrements ? [NSString stringWithFormat:@"-%.0f:%02.0f", minutesRemaining, secondsRemaining] : [NSString stringWithFormat:@"%.0f:%02.0f", minutesRemaining, secondsRemaining];
}

- (void)monitorMoviePlayback {
    double currentTime = floor(self.moviePlayer.currentPlaybackTime);
    double totalTime = floor(self.moviePlayer.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
    self.durationSlider.value = ceil(currentTime);
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end

# pragma mark - ALMoviePlayerControlsBar

@implementation ALMoviePlayerControlsBar

- (id)init {
    if ( self = [super init] ) {
        self.opaque = NO;
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = color;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [_color CGColor]);
    CGContextFillRect(context, rect);
}

@end
