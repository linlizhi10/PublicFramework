//
//  ViewController.m
//  TestAVPlayer
//
//  Created by Mike on 2014-05-07.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "KSVideoPlayerView.h"
#import "KeepLayout.h"


@implementation KSVideoPlayerView
{
    id playbackObserver;
    AVPlayerLayer *playerLayer;
    BOOL viewIsShowing;
    NSTimer *timer;
    
    
    UIView *loadView;
    UIImageView *loadImageView;
    UIActivityIndicatorView *activityIndicatorView;
    
    UIDeviceOrientation currentOrientation;
}

-(id)initWithFrame:(CGRect)frame playerItem:(AVPlayerItem*)playerItem
{
    self = [super initWithFrame:frame];
    //在此获取创建的view，如果在一个xib上创建了多个view，则要根据实际的view的顺序进行获取
//    self = [[[NSBundle mainBundle] loadNibNamed:@"XLMoreView" owner:self options:nil] firstObject];
    if (self) {
        self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
        playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
        [playerLayer setFrame:frame];
        [self.moviePlayer seekToTime:kCMTimeZero];
        [self.layer addSublayer:playerLayer];
        self.contentURL = nil;
        self.playerItem = playerItem;
        
        
        [self initLoadView];
        
        [self initializePlayer:frame];
        
        [self initPlayer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame contentURL:(NSURL*)contentURL
{
    self = [super initWithFrame:frame];
    if (self) {
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
        self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
        playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
        [playerLayer setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.moviePlayer seekToTime:kCMTimeZero];
        [self.layer addSublayer:playerLayer];
        self.contentURL = contentURL;
        self.playerItem = playerItem;
        [self initLoadView];
        
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinishedPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        
        [self initializePlayer:frame];
        
        [self initPlayer];
    }
    return self;
}


- (void)playVideoByURL:(NSURL*)contentURL{
    
    
    
    [playerLayer removeFromSuperlayer];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
    self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
    [playerLayer setFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.moviePlayer seekToTime:kCMTimeZero];
    [self.layer addSublayer:playerLayer];
    
    
    self.contentURL = contentURL;
    self.playerItem = playerItem;
    [self initPlayer];
    
    [self play];
    
    [self bringSubviewToFront:self.playerHudTop];
    [self bringSubviewToFront:self.playerHudBottom];
}

- (void)playVideoByURL:(NSURL*)contentURL isPlay:(BOOL)isPlay{
    
    
    
    [playerLayer removeFromSuperlayer];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
    self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
    [playerLayer setFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.moviePlayer seekToTime:kCMTimeZero];
    [self.layer addSublayer:playerLayer];
    
    
    self.contentURL = contentURL;
    self.playerItem = playerItem;
    [self initPlayer];
    
    if (isPlay) {
        [self play];
    } else {
        [self pause];
    }
    
    [self bringSubviewToFront:self.playerHudTop];
    [self bringSubviewToFront:self.playerHudBottom];
}

- (void)initLoadView{
    loadView = [[UIView alloc] initWithFrame:playerLayer.frame];
    loadView.backgroundColor = [UIColor greenColor];
    
    loadImageView = [[UIImageView alloc] initWithFrame:loadView.frame];
    loadImageView.image = [QHCommonUtil imageNamed:@"xdf_video_load_default_bg"];
    [loadView addSubview:loadImageView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//指定进度轮的大小
    [activityIndicatorView setCenter:loadView.center];//指定进度轮中心点
    
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    //开始显示Loading动画
    [activityIndicatorView startAnimating];
    [loadView addSubview:activityIndicatorView];
    
    [self addSubview:loadView];
    
}

- (void)initPlayer{
    
    
    if (self.playerItem) {
        [self.playerItem addObserver:self
                          forKeyPath:@"status"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
        
        [self.playerItem addObserver:self
                          forKeyPath:@"playbackBufferEmpty"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
        
        [self.playerItem addObserver:self
                          forKeyPath:@"playbackLikelyToKeepUp"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
        
        [self.playerItem addObserver:self
                          forKeyPath:@"loadedTimeRanges"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinishedPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        
        
        // iOS 5
        [self.moviePlayer addObserver:self forKeyPath:@"airPlayVideoActive" options:NSKeyValueObservingOptionNew context:nil];
        
        // iOS 6
        [self.moviePlayer addObserver:self
                           forKeyPath:@"externalPlaybackActive"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        
        
        CMTime interval = CMTimeMake(33, 1000);
        __weak __typeof(self) weakself = self;
        playbackObserver = [self.moviePlayer addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock: ^(CMTime time) {
            CMTime endTime = CMTimeConvertScale (weakself.moviePlayer.currentItem.asset.duration, weakself.moviePlayer.currentTime.timescale, kCMTimeRoundingMethod_RoundHalfAwayFromZero);
            if (CMTimeCompare(endTime, kCMTimeZero) != 0) {
                double normalizedTime = (double) weakself.moviePlayer.currentTime.value / (double) endTime.value;
                weakself.progressSlider.value = normalizedTime;
            }
            weakself.playBackTime.text = [weakself getStringFromCMTime:weakself.moviePlayer.currentTime];
        }];
        
        //    [self setupConstraints];
        //    [self showHud:NO];
        
        
        //横竖屏监控
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [self performSelectorInBackground:@selector(initPlayTime) withObject:nil];
        
        
        [self startTimer];
    }
    
    
//    if (!self.videoPlayer) {
//        _videoPlayer = [AVPlayer playerWithPlayerItem:playerItem];
//        [_videoPlayer setAllowsAirPlayVideo:YES];
//        [_videoPlayer setUsesAirPlayVideoWhileAirPlayScreenIsActive:YES];
//        
//        if ([_videoPlayer respondsToSelector:@selector(setAllowsExternalPlayback:)]) { // iOS 6 API
//            [_videoPlayer setAllowsExternalPlayback:YES];
//        }
//        
//        [_videoPlayerView setPlayer:_videoPlayer];
//    } else {
//        [self removeObserversFromVideoPlayerItem];
//        [self.videoPlayer replaceCurrentItemWithPlayerItem:playerItem];
//    }
    
    
    
    
    
    
    
    
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [playerLayer setFrame:frame];
}

-(void) setupConstraints
{
    
    //top HUD view
//    self.playerHudTop.keepHorizontalInsets.equal = KeepRequired(0);
//    self.playerHudTop.keepBottomInset.equal = KeepRequired(0);
    
//    self.playerHudTop.keepHorizontalInsets.equal = KeepRequired(0);
//    self.playerHudTop.keepTopInset.equal = KeepRequired(0);
    
    self.playerHudTop.keepHeightTo(self.progressSlider).equal = KeepRequired(10);
//    [self.playerHudTop keepVerticallyCentered];
    
    // bottom HUD view
    self.playerHudBottom.keepHorizontalInsets.equal = KeepRequired(0);
    self.playerHudBottom.keepBottomInset.equal = KeepRequired(0);
    
    // play/pause button
    [self.playPauseButton keepHorizontallyCentered];
    [self.playPauseButton keepVerticallyCentered];
    
    // current time label
    self.playBackTime.keepLeftInset.equal = KeepRequired(5);
    [self.playBackTime keepVerticallyCentered];
    
    
    // progress bar
    self.progressSlider.keepLeftOffsetTo(self.playBackTime).equal = KeepRequired(5);
    self.progressSlider.keepBottomInset.equal = KeepRequired(0);
    [self.progressSlider keepVerticallyCentered];
    
//    self.loadProgressView.keepLeftOffsetTo(self.playBackTime).equal = KeepRequired(5);
//    self.loadProgressView.keepBottomInset.equal = KeepRequired(0);
//    self.loadProgressView.progress = 0.5;
//    [self.loadProgressView keepVerticallyCentered];
//    self.loadProgressView.keepLeftAlignTo(self.progressSlider).equal = KeepRequired(0);
    
    // total time label
    self.playBackTotalTime.keepLeftOffsetTo(self.progressSlider).equal = KeepRequired(5);
    [self.playBackTotalTime keepVerticallyCentered];
    
    // zoom button
    self.zoomButton.keepRightInset.equal = KeepRequired(5);
    [self.zoomButton keepVerticallyCentered];
    
    // airplay button
    self.airplayButton.keepRightOffsetTo(self.zoomButton).equal = KeepRequired(self.airplayButton.frame.size.width);
    self.airplayButton.keepLeftOffsetTo(self.playBackTotalTime).equal = KeepRequired(5);
    self.airplayButton.keepBottomInset.equal = KeepRequired(6);
    [self.airplayButton keepVerticallyCentered];
    
}

-(void)initializePlayer:(CGRect)frame
{
    int frameWidth =  frame.size.width;
    int frameHeight = frame.size.height;
    
    self.backgroundColor = [UIColor blackColor];
    viewIsShowing =  YES;
    
    [self.layer setMasksToBounds:YES];
    
    //关闭
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(0, 20, 44, 36);
    [self.closeBtn setImage:[UIImage imageNamed:@"video_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    //竖屏下载
    self.pDownloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pDownloadBtn.frame = CGRectMake(320-36 - 8, 20, 44, 36);
    [self.pDownloadBtn setImage:[UIImage imageNamed:@"download_icon"] forState:UIControlStateNormal];
    [self.pDownloadBtn addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pDownloadBtn];
    
    //上部View
    self.playerHudTop = [[UIView alloc] init];
    self.playerHudTop.frame = CGRectMake(0, 0, frameWidth, 36);
    [self.playerHudTop setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    self.playerHudTop.hidden = YES;
    [self addSubview:self.playerHudTop];
    
    
    //返回
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 20, 44, 36);
    [self.backBtn setImage:[UIImage imageNamed:@"video_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(zoomButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerHudTop addSubview:self.backBtn];
    
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, frameWidth-88, 36)];
    //    [self.playBackTime sizeToFit];
    self.titleLabel.text = @"视频标题，欢迎收看,是打发沙发是的发送到发送到发送到分啦啦啦";
//    self.titleLabel.numberOfLines = 0;
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        self.titleLabel.backgroundColor = [UIColor greenColor];
    [self.playerHudTop addSubview:self.titleLabel];
    
    
    //横屏下载
    self.hDownloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hDownloadBtn.frame = CGRectMake(self.titleLabel.frame.size.width - 44, 20, 44, 36);
    [self.hDownloadBtn setImage:[UIImage imageNamed:@"download_icon"] forState:UIControlStateNormal];
    [self.hDownloadBtn addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playerHudTop addSubview:self.hDownloadBtn];
    
    
    
    self.playerHudBottom = [[UIView alloc] init];
    self.playerHudBottom.frame = CGRectMake(0, 0, frameWidth, 25);
    [self.playerHudBottom setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    [self addSubview:self.playerHudBottom];
    
    //    self.playerHudBottomBGView = [[UIView alloc] init];
    //    self.playerHudBottomBGView.frame = CGRectMake(0, 0, frameWidth, 48*frameHeight/160);
    //    self.playerHudBottomBGView.backgroundColor = [UIColor blackColor];
    //
    //    // Create the colors for our gradient.
    //    UIColor *transparent = [UIColor colorWithWhite:1.0f alpha:0.f];
    //    UIColor *opaque = [UIColor colorWithWhite:1.0f alpha:1.0f];
    //
    //    // Create a masklayer.
    //    CALayer *maskLayer = [[CALayer alloc]init];
    //    maskLayer.frame = self.playerHudBottomBGView.bounds;
    //    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    //    gradientLayer.frame = CGRectMake(0,0,self.playerHudBottomBGView.bounds.size.width, self.playerHudBottomBGView.bounds.size.height);
    //    gradientLayer.colors = @[(id)transparent.CGColor, (id)transparent.CGColor, (id)opaque.CGColor, (id)opaque.CGColor];
    //    gradientLayer.locations = @[@0.0f, @0.09f, @0.8f, @1.0f];
    //
    //    // Add the mask.
    //    [maskLayer addSublayer:gradientLayer];
    //    self.playerHudBottomBGView.layer.mask = maskLayer;
    
    //    [self.playerHudBottom addSubview:self.playerHudBottomBGView];
    
    //Play Pause Button
    self.playPauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.playPauseButton.frame = CGRectMake(0, 0, 44, 44);
    [self.playPauseButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.playPauseButton setSelected:NO];
    [self.playPauseButton setBackgroundImage:[UIImage imageNamed:@"playback_pause"] forState:UIControlStateSelected];
    [self.playPauseButton setBackgroundImage:[UIImage imageNamed:@"playback_play"] forState:UIControlStateNormal];
    [self.playPauseButton setTintColor:[UIColor clearColor]];
    //    self.playPauseButton.layer.opacity = 0;
    [self.playerHudBottom addSubview:self.playPauseButton];
    
    
    //Current Time Label
    self.playBackTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 12)];
    //    [self.playBackTime sizeToFit];
//    self.playBackTime.text = [self getStringFromCMTime:self.moviePlayer.currentTime];
    self.playBackTime.text = @"00:00:00";
    [self.playBackTime setTextAlignment:NSTextAlignmentCenter];
    [self.playBackTime setTextColor:[UIColor whiteColor]];
    self.playBackTime.font = [UIFont systemFontOfSize:12.0f];
    [self.playerHudBottom addSubview:self.playBackTime];
    
    
    self.sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 6, 12)];
    //    [self.playBackTime sizeToFit];
    self.sepLabel.text = @"/";
    [self.sepLabel setTextAlignment:NSTextAlignmentCenter];
    [self.sepLabel setTextColor:[UIColor grayColor]];
    self.sepLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.playerHudBottom addSubview:self.sepLabel];
    
    
    //Total Time label
    self.playBackTotalTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 12)];
    //    [self.playBackTotalTime sizeToFit];
//    self.playBackTotalTime.text = [self getStringFromCMTime:self.moviePlayer.currentItem.asset.duration];
    self.playBackTotalTime.text = @"00:00:00";
    [self.playBackTotalTime setTextAlignment:NSTextAlignmentCenter];
    [self.playBackTotalTime setTextColor:[UIColor grayColor]];
    self.playBackTotalTime.font = [UIFont systemFontOfSize:12.0f];
    //    self.playBackTotalTime.backgroundColor = [UIColor redColor];
    [self.playerHudBottom addSubview:self.playBackTotalTime];
    
    
    //    UIProgressView *loadProgressView = [[UIProgressView alloc] init];
    //    loadProgressView.frame = CGRectMake(0, 0, frameWidth, 100);
    //    loadProgressView.progressViewStyle= UIProgressViewStyleDefault;
    //    loadProgressView.progressTintColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1.0];
    //    loadProgressView.trackTintColor = [UIColor darkGrayColor];
    //    loadProgressView.backgroundColor = [UIColor greenColor];
    UIProgressView *loadProgressView = [[UIProgressView alloc] init];
    loadProgressView.frame = CGRectMake(0, 0, 320, 15);
    loadProgressView.progressViewStyle= UIProgressViewStyleDefault;
    loadProgressView.progressTintColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1.0];
    //    loadProgressView.trackTintColor = [UIColor redColor];
    loadProgressView.backgroundColor = [UIColor greenColor];
    
    loadProgressView.progress = 0;
    self.loadProgressView = loadProgressView;
    [self.playerHudBottom addSubview:loadProgressView];
    
    //Seek Time Progress Bar
    self.progressSlider = [[UISlider alloc] init];
    self.progressSlider.frame = CGRectMake(0, 0, frameWidth, 4);
    [self.progressSlider addTarget:self action:@selector(progressBarChanged:) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(proressBarChangeEnded:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.progressBar setThumbImage:[UIImage imageNamed:@"Slider_button"] forState:UIControlStateNormal];
    
    
    [self.progressSlider setMinimumTrackTintColor:RGBCOLOR(40, 174, 148)];
    //    [self.progressBar setMinimumTrackImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"slider_bg"] forState:UIControlStateNormal];
    [self.progressSlider setThumbTintColor:[UIColor clearColor]];
    
    
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"slider_icon"];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [self.progressSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self.progressSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    
    //左右轨的图片
    //    UIImage *stetchLeftTrack= [UIImage imageNamed:@"red.png"];
    //    UIImage *stetchRightTrack = [UIImage imageNamed:@"transparentBar"];;
    //    //滑块图片
    //    UIImage *thumbImage = [UIImage imageNamed:@"hint"];
    ////    [self.progressBar setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    //    [self.progressBar setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    //    [self.progressBar setThumbImage:thumbImage forState:UIControlStateHighlighted];
    //    [self.progressBar setThumbImage:thumbImage forState:UIControlStateNormal];
    
    //    self.progressBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
    [self.playerHudBottom addSubview:self.progressSlider];
    
    
    
    //zoom button
    UIImage *image = [UIImage imageNamed:@"zoomout"];
    self.zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.zoomButton.frame = CGRectMake(0,0,44, 44);
    [self.zoomButton addTarget:self action:@selector(zoomButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.zoomButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.playerHudBottom addSubview:self.zoomButton];
    
    
    self.volumeView = [[MPVolumeView alloc] init];
//    self.volumeView.backgroundColor = [UIColor redColor];
    [self.volumeView setShowsRouteButton:NO];
    [self.volumeView setShowsVolumeSlider:YES];
    self.volumeView.transform =   CGAffineTransformIdentity;
    self.volumeView.transform =   CGAffineTransformMakeRotation(-M_PI/2);
    self.volumeView.frame = CGRectMake(-40, 70, 30, 180);
    [self addSubview:self.volumeView];
    
    //初始化视图位置
    [self initPortraitLayout];
    
    
    for (UIView *view in [self subviews]) {
//        view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    
    /*
    CMTime interval = CMTimeMake(33, 1000);
    __weak __typeof(self) weakself = self;
    playbackObserver = [self.moviePlayer addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock: ^(CMTime time) {
        CMTime endTime = CMTimeConvertScale (weakself.moviePlayer.currentItem.asset.duration, weakself.moviePlayer.currentTime.timescale, kCMTimeRoundingMethod_RoundHalfAwayFromZero);
        if (CMTimeCompare(endTime, kCMTimeZero) != 0) {
            double normalizedTime = (double) weakself.moviePlayer.currentTime.value / (double) endTime.value;
            weakself.progressSlider.value = normalizedTime;
        }
        weakself.playBackTime.text = [weakself getStringFromCMTime:weakself.moviePlayer.currentTime];
    }];
    
    //    [self setupConstraints];
//    [self showHud:NO];
    
    
    //横竖屏监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self performSelectorInBackground:@selector(initPlayTime) withObject:nil];
    
    
    [self startTimer];
     */
}

- (void)closeClick{
    [self.delegate closePlayerView:self];
}
- (void)downloadClick{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否开始下载？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
    [self.delegate downloadVideo:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        
    }
    else {
        
    }
}

- (void)startTimer{
    if (timer==nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(initHubViewShowing:) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}


//timer调用函数
-(void)initHubViewShowing:(NSTimer *)timer{
    [self showHud:viewIsShowing];
}


- (void)initPlayTime{
    self.playBackTime.text = [self getStringFromCMTime:self.moviePlayer.currentTime];
    //Total Time label
    self.playBackTotalTime.text = [self getStringFromCMTime:self.moviePlayer.currentItem.asset.duration];
}

-(void)zoomButtonPressed:(UIButton*)sender
{
//    [UIView animateWithDuration:0.5 animations:^{
//        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
//    }];
    [self.delegate playerViewZoomButtonClicked:self];
}

-(void)setIsFullScreenMode:(BOOL)isFullScreenMode
{
    _isFullScreenMode = isFullScreenMode;
    if (isFullScreenMode) {
        self.backgroundColor = [UIColor blackColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - 播放完成
-(void)playerFinishedPlaying
{
    [self.moviePlayer pause];
    [self.moviePlayer seekToTime:kCMTimeZero];
    [self.playPauseButton setSelected:NO];
    self.isPlaying = NO;
    if ([self.delegate respondsToSelector:@selector(playerFinishedPlayback:)]) {
        [self.delegate playerFinishedPlayback:self];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [(UITouch*)[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(playerLayer.frame, point)) {
        [self showHud:viewIsShowing];
    }
}

-(void) showHud:(BOOL)show
{
    __weak __typeof(self) weakself = self;
//    UIResponder *nextResponder = [[self superview] nextResponder];
//    PlayVideoViewController *playVideoViewController;
//    if ([nextResponder isKindOfClass:[UIViewController class]]) {
////    return (UIViewController *)nextResponder;
//    }
    
    
    if(show) {//隐藏
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
        
        CGRect frame = self.playerHudBottom.frame;
        frame.origin.y = self.bounds.size.height;
        
        CGRect frame1 = self.playerHudTop.frame;
        
        frame1.origin.y = -self.playerHudTop.frame.size.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            weakself.playerHudBottom.frame = frame;
            weakself.playerHudTop.frame = frame1;
            //            weakself.playPauseButton.layer.opacity = 0;
            weakself.volumeView.layer.opacity = 0;
            viewIsShowing = !show;
            
            
            [weakself stopTimer];
        }];
        
        
    } else {//显示
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        
        CGRect frame = self.playerHudBottom.frame;
        frame.origin.y = self.bounds.size.height-self.playerHudBottom.frame.size.height;
        
        CGRect frame1 = self.playerHudTop.frame;
        frame1.origin.y = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            weakself.playerHudBottom.frame = frame;
            weakself.playerHudTop.frame = frame1;
            //            weakself.playPauseButton.layer.opacity = 1;
            weakself.volumeView.layer.opacity = 1;
            viewIsShowing = !show;
            
            [weakself startTimer];
        }];
        
        
    }
}

-(NSString*)getStringFromCMTime:(CMTime)time
{
    Float64 currentSeconds = CMTimeGetSeconds(time);
    int mins = currentSeconds/60.0;
    int hours = mins / 60.0f;
    int secs = fmodf(currentSeconds, 60.0);
    mins = fmodf(mins, 60.0f);
    
    NSString *hoursString = hours < 10 ? [NSString stringWithFormat:@"0%d", hours] : [NSString stringWithFormat:@"%d", hours];
    NSString *minsString = mins < 10 ? [NSString stringWithFormat:@"0%d", mins] : [NSString stringWithFormat:@"%d", mins];
    NSString *secsString = secs < 10 ? [NSString stringWithFormat:@"0%d", secs] : [NSString stringWithFormat:@"%d", secs];
    
    
    return [NSString stringWithFormat:@"%@:%@:%@", hoursString,minsString, secsString];
}

//-(void)volumeButtonPressed:(UIButton*)sender
//{
//    if (sender.isSelected) {
//        [self.moviePlayer setMuted:YES];
//        [sender setSelected:NO];
//    } else {
//        [self.moviePlayer setMuted:NO];
//        [sender setSelected:YES];
//    }
//}

-(void)playButtonAction:(UIButton*)sender
{
    if (self.isPlaying) {
        [self pause];
//        [sender setSelected:NO];
    } else {
        [self play];
//        [sender setSelected:YES];
    }
}

-(void)progressBarChanged:(UISlider*)sender
{
    [self stopTimer];
    
    if (self.isPlaying) {
        [self.moviePlayer pause];
    }
    CMTime seekTime = CMTimeMakeWithSeconds(sender.value * (double)self.moviePlayer.currentItem.asset.duration.value/(double)self.moviePlayer.currentItem.asset.duration.timescale, self.moviePlayer.currentTime.timescale);
    [self.moviePlayer seekToTime:seekTime];
}

-(void)proressBarChangeEnded:(UISlider*)sender
{
    [self startTimer];
    if (self.isPlaying) {
        [self.moviePlayer play];
    }
}

-(void)volumeBarChanged:(UISlider*)sender
{
    [self.moviePlayer setVolume:sender.value];
}

-(void)play
{
    [self.moviePlayer play];
    self.isPlaying = YES;
    [self.playPauseButton setSelected:YES];
}

-(void)pause
{
    [self.moviePlayer pause];
    self.isPlaying = NO;
    [self.playPauseButton setSelected:NO];
}

- (void)stop{
    [self stopTimer];
    
    if (viewIsShowing) {
//        [self showHud:viewIsShowing];
    }
    loadView.hidden = NO;
    [self.moviePlayer pause];
    [self.moviePlayer seekToTime:kCMTimeZero];
    [self.loadProgressView setProgress:0];
    [self.playPauseButton setSelected:NO];
    self.isPlaying = NO;
    
    @try {
        [self.moviePlayer removeTimeObserver:playbackObserver];
        [self.moviePlayer removeObserver:self forKeyPath:@"airPlayVideoActive"];
        [self.moviePlayer removeObserver:self forKeyPath:@"externalPlaybackActive"];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
   
}

//-(void)dealloc
//{
//    [self.moviePlayer removeTimeObserver:playbackObserver];
//    [self.moviePlayer removeObserver:self forKeyPath:@"airPlayVideoActive"];
//    [self.moviePlayer removeObserver:self forKeyPath:@"externalPlaybackActive"];
//    [self.playerItem removeObserver:self forKeyPath:@"status"];
//    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
//    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
//    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


//*****************处理旋转屏幕*******************

- (void)orientationDidChange:(NSNotification *)note
{
    NSLog(@"new orientation = %d", [[UIDevice currentDevice] orientation]);
    [self setNeedsLayout];
    [UIView animateWithDuration:0.5 animations:^{
        if(UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            
        } else {
            
        }
    } completion:^(BOOL finished) {
        
    }];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    
    if (deviceOrientation == UIDeviceOrientationFaceUp || deviceOrientation == UIDeviceOrientationFaceDown) {
        deviceOrientation = currentOrientation;
    } else {
        currentOrientation = deviceOrientation;
    }
    
    if(UIDeviceOrientationIsLandscape(deviceOrientation)) {//横屏
        [self initLandscapeLayout];
    } else {//竖屏
        [self initPortraitLayout];
    }
    
    
}


- (void)initLandscapeLayout{
    self.playerHudTop.hidden = NO;
    
    self.closeBtn.hidden = YES;
    self.pDownloadBtn.hidden = YES;
    
    
    loadView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    loadImageView.frame = loadView.frame;
    activityIndicatorView.center = loadView.center;
    
    self.volumeView.frame = CGRectMake(20, 70, 30, 180);
    
    
    if(viewIsShowing){//显示
        self.playerHudTop.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    } else {
        self.playerHudTop.frame = CGRectMake(0, -60, self.frame.size.width, 60);
    }
    
    
    self.titleLabel.frame = CGRectMake(44, 20, self.playerHudTop.frame.size.width - 88, 36);
    
    setXYWithRightView(self.hDownloadBtn, 0, 0, self.titleLabel);
    
    if (viewIsShowing) {
        self.playerHudBottom.frame = CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44);
    } else {
        self.playerHudBottom.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, 44);
    }
    
    
    self.playPauseButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.zoomButton.frame = CGRectMake(self.frame.size.width - 54, 0, 44, 44);
    
    setXYWithRightView(self.loadProgressView, 12, self.playPauseButton.frame.size.height/2, self.playPauseButton);
    CGRect rect1 = self.loadProgressView.frame;
    rect1.size.width = self.zoomButton.frame.origin.x - rect1.origin.x - 10 - 2;
    self.loadProgressView.frame = rect1;
    
    setXYWithRightView(self.progressSlider, 10, 0, self.playPauseButton);
    CGRect rect2 = self.progressSlider.frame;
    rect2.size.width = self.zoomButton.frame.origin.x - rect2.origin.x - 10;
    rect2.origin.y = self.playerHudBottom.frame.size.height/2 - self.progressSlider.frame.size.height/2;
    self.progressSlider.frame = rect2;
    
    setXYWithAboveView(self.playBackTotalTime,  self.loadProgressView.frame.size.width- self.playBackTotalTime.frame.size.width, 5, self.loadProgressView);
    setXWithLeftView(self.sepLabel, 0, self.playBackTotalTime);
    setXWithLeftView(self.playBackTime, 0, self.sepLabel);
    
    [self.zoomButton setBackgroundImage:[UIImage imageNamed:@"zoomin"] forState:UIControlStateNormal];
//    [self bringSubviewToFront:self.closeBtn];
}

- (void)initPortraitLayout{
    self.playerHudTop.hidden = YES;
    
    self.closeBtn.hidden = NO;
    self.pDownloadBtn.hidden = NO;
    
    loadView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    loadImageView.frame = loadView.frame;
    activityIndicatorView.center = loadView.center;
    
    self.volumeView.frame = CGRectMake(-40, 70, 30, 180);
    if(viewIsShowing){//显示
        self.playerHudTop.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    } else {
        self.playerHudTop.frame = CGRectMake(0, -60, self.frame.size.width, 60);
    }
    
    self.titleLabel.frame = CGRectMake(44, 20, self.playerHudTop.frame.size.width - 88, 40);
    
    if (viewIsShowing) {
        self.playerHudBottom.frame = CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44);
    } else {
        self.playerHudBottom.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, 44);
    }
    
    
    //处理顶部view布局
    //        self.playerHudTop.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    //        self.titleLabel.frame = CGRectMake(44, 20, self.playerHudTop.frame.size.width - 88, 40);
    //        self.playerHudBottom.frame = CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44);
    
    self.playPauseButton.frame = CGRectMake(0, 0, 44, 44);
    self.zoomButton.frame = CGRectMake(self.frame.size.width - 54, 0, 44, 44);
    
    setXYWithRightView(self.loadProgressView, 12, self.playPauseButton.frame.size.height/2, self.playPauseButton);
    CGRect rect1 = self.loadProgressView.frame;
    rect1.size.width = self.zoomButton.frame.origin.x - rect1.origin.x - 10 - 2;
    self.loadProgressView.frame = rect1;
    
    
    setXYWithRightView(self.progressSlider, 10, 0, self.playPauseButton);
    CGRect rect2 = self.progressSlider.frame;
    rect2.size.width = self.zoomButton.frame.origin.x - rect2.origin.x - 10;
    rect2.origin.y = self.playerHudBottom.frame.size.height/2 - self.progressSlider.frame.size.height/2;
    self.progressSlider.frame = rect2;
    
    
    setXYWithAboveView(self.playBackTotalTime,  self.loadProgressView.frame.size.width- self.playBackTotalTime.frame.size.width, 5, self.loadProgressView);
    setXWithLeftView(self.sepLabel, 0, self.playBackTotalTime);
    setXWithLeftView(self.playBackTime, 0, self.sepLabel);
    
    [self.zoomButton setBackgroundImage:[UIImage imageNamed:@"zoomout"] forState:UIControlStateNormal];
    [self bringSubviewToFront:self.closeBtn];
    [self bringSubviewToFront:self.pDownloadBtn];
}






// Wait for the video player status to change to ready before initializing video player controls
#pragma mark - 观察视频播放各个监听触发
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.moviePlayer
        && ([keyPath isEqualToString:@"externalPlaybackActive"] || [keyPath isEqualToString:@"airPlayVideoActive"])) {
        BOOL externalPlaybackActive = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
//        [[_videoPlayerView airplayIsActiveView] setHidden:!externalPlaybackActive];
        DLog(@"55555555555555555555555555555");
        return;
    }
    
    if (object != [self.moviePlayer currentItem]) {
        return;
    }
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:
//                playWhenReady = YES;
                DLog(@"44444444444444444444444444444");
                [loadView setHidden:YES];
                break;
            case AVPlayerStatusFailed:
                // TODO:
//                [self removeObserversFromVideoPlayerItem];
//                [self removePlayerTimeObservers];
//                self.moviePlayer = nil;
                NSLog(@"failed");
                DLog(@"333333333333333333333333333333333333");
                break;
        }
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"] && self.moviePlayer.currentItem.playbackBufferEmpty) {
        self.playerIsBuffering = YES;
//        [[_videoPlayerView activityIndicator] startAnimating];
//        [self syncPlayPauseButtons];
        DLog(@"222222222222222222222222222222222222222");
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"] && self.moviePlayer.currentItem.playbackLikelyToKeepUp) {
//        if (![self isPlaying] && (playWhenReady || self.playerIsBuffering || scrubBuffering)) {
//            [self playVideo];
//        }
//        [[_videoPlayerView activityIndicator] stopAnimating];
        
        DLog(@"11111111111111111111111111111111111");
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        float durationTime = CMTimeGetSeconds([[self.moviePlayer currentItem] duration]);
        float bufferTime = [self availableDuration];
        [self.loadProgressView setProgress:bufferTime/durationTime animated:YES];
        DLog(@"6666666666666666666666666666");
        
        if (self.playerIsBuffering && self.isPlaying) {
            [self.moviePlayer play];
            self.playerIsBuffering = NO;
        }
    }
    
    return;
}


- (float)availableDuration
{
    NSArray *loadedTimeRanges = [[self.moviePlayer currentItem] loadedTimeRanges];
    
    // Check to see if the timerange is not an empty array, fix for when video goes on airplay
    // and video doesn't include any time ranges
    if ([loadedTimeRanges count] > 0) {
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        return (startSeconds + durationSeconds);
    } else {
        return 0.0f;
    }
}


- (void)playOther:(NSURL*)contentURL{
    
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
//    self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
//    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
//    [playerLayer setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    [self.moviePlayer seekToTime:kCMTimeZero];
//    [self.layer addSublayer:playerLayer];
//    self.contentURL = contentURL;
//    self.playerItem = playerItem;
//    [self initPlayer];
    
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:contentURL];
    self.moviePlayer = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
    [self.moviePlayer seekToTime:kCMTimeZero];
    [self initPlayer];
}

@end
