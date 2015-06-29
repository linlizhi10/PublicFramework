//
//  ViewController.m
//  TestAVPlayer
//
//  Created by Mike on 2014-05-07.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@class KSVideoPlayerView;

@protocol playerViewDelegate <NSObject>
@optional
-(void)playerViewZoomButtonClicked:(KSVideoPlayerView*)view;
-(void)playerFinishedPlayback:(KSVideoPlayerView*)view;

- (void)closePlayerView:(KSVideoPlayerView*)view;
- (void)downloadVideo:(KSVideoPlayerView*)view;

@end

@interface KSVideoPlayerView : UIView <UIAlertViewDelegate>

@property (assign, nonatomic) id <playerViewDelegate> delegate;
@property (assign, nonatomic) BOOL isFullScreenMode;
@property (retain, nonatomic) NSURL *contentURL;
@property (retain, nonatomic) AVPlayer *moviePlayer;
@property (retain, nonatomic) AVPlayerItem *playerItem;
@property (assign, nonatomic) BOOL isPlaying;

@property (assign, nonatomic) BOOL playerIsBuffering;



@property (retain, nonatomic) UIButton *playPauseButton;
@property (retain, nonatomic) UIButton *volumeButton;
@property (retain, nonatomic) UIButton *zoomButton;
@property (retain, nonatomic) MPVolumeView *airplayButton;

@property (nonatomic, strong) UIProgressView *loadProgressView;
@property (retain, nonatomic) UISlider *progressSlider;
@property (retain, nonatomic) UISlider *volumeBar;

@property (retain, nonatomic) UILabel *playBackTime;
@property (retain, nonatomic) UILabel *sepLabel;
@property (retain, nonatomic) UILabel *playBackTotalTime;

@property (retain,nonatomic) UIView *playerHudCenter;
@property (retain,nonatomic) UIView *playerHudBottom;
@property (nonatomic, strong) MPVolumeView *volumeView;

//顶部view
@property (nonatomic,strong) UIView *playerHudTop;
@property (retain, nonatomic) UILabel *titleLabel;


//关闭
@property (nonatomic,strong) UIButton *closeBtn;//关闭按钮
//返回
@property (nonatomic,strong) UIButton *backBtn;//返回按钮
//下载
@property (nonatomic,strong) UIButton *pDownloadBtn;//竖屏下载按钮
@property (nonatomic,strong) UIButton *hDownloadBtn;//横屏下载按钮


- (id)initWithFrame:(CGRect)frame contentURL:(NSURL*)contentURL;
-(id)initWithFrame:(CGRect)frame playerItem:(AVPlayerItem*)playerItem;
-(void)play;
-(void)pause;
- (void)stop;
-(void) setupConstraints;

- (void)playVideoByURL:(NSURL*)contentURL;
- (void)playVideoByURL:(NSURL*)contentURL isPlay:(BOOL)isPlay;

@end
