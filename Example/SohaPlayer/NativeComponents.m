//
//  NativeComponents.m
//  SohaPlayerDemo
//
//  Created by Le Cuong on 10/18/16.
//  Copyright © 2016 Le Cuong. All rights reserved.
//

#import "NativeComponents.h"
#import "NativeControlsView.h"
#import <SohaPlayer/SHViewController.h>
#import "NSCacheManager.h"

#import <AVFoundation/AVFoundation.h>

#define URL_TESTxx @"https://hls.mediacdn.vn/kinglive/c6550ad6f7fcf8ae27a25e265a99b2de-21-Jun-17-10:24:34.flv/mobile.m3u8"
#define URL_TEST @"http://nb7.mediacdn.vn/dev93/0/035/604/0035604651.mp4?name=premierleague/video/20170522105224/100354649_1200_96_1080p.mp4"
#define URL_TEST2 @"http://play.sohatv.vn/?v=Z2Vuaw=="
#define URL_TEST3 @"http://www.mediacollege.com/video-gallery/testclips/barsandtone.flv"


@interface NativeComponents () <NativeControlsDelegate, SHViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *playerContainer;
@property (weak, nonatomic) IBOutlet NativeControlsView *nativeControls;

@property AVPlayer *avPlayer;
@property AVPlayerItem *item;
@property AVPlayerLayer *layerPlay;

@property (retain, nonatomic) SHViewController *player;

@end


@implementation NativeComponents{
    SHPlayerConfig *config;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nativeControls.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
     [self setupPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPlayer{
//    config = [[SHPlayerConfig alloc] initWithShortLinkUrl:URL_TESTxx appkey:nil secretKey:nil vid:nil];
    config = [[SHPlayerConfig alloc] initWithSourceUrl:URL_TESTxx appkey:nil secretKey:nil vid:nil];
    
    _player = [[SHViewController alloc] initWithConfiguration:config webRq:NO];
    
    _player.delegate = self;
    
    [_player loadPlayerIntoViewController:self];
    
    [_player.view setFrame:self.playerContainer.bounds];
    
    [self.playerContainer insertSubview:_player.view atIndex:0];
    
    [self.player.SHPlayer setlayerGravity:AVLayerVideoGravityResize];
}

- (void)updateCurrentPlaybackTime:(double)currentPlaybackTime{
//    NSLog(@"updateCurrentPlaybackTime: %f",currentPlaybackTime);
    
    [_nativeControls.progressSlider setValue:currentPlaybackTime];
}

- (void)SHPlayer:(SHViewController*)player playerLoadStateDidChange:(SHMediaLoadState)state
{
    NSLog(@"player Load State Did Change %lu",(unsigned long)state);
}
- (void)SHPlayer:(SHViewController*)player playerPlaybackStateDidChange:(SHMediaPlaybackState)state
{
    NSLog(@"state player %ld",(long)state);
    
}
- (void)SHPlayer:(SHViewController*)player playerFullScreenToggled:(BOOL)isFullScreen
{
    
}
- (void)SHPlayer:(SHViewController*)player didFailWithError:(NSError*)error
{
    
}


- (void)play {
    [self.player.SHPlayer play];
    [config getCurrentTimeVideoWithSuccess:^(float time, NSString * _Nullable error) {
        //
        NSLog(@"time get %f",time);
        NSLog(@"error get time %@",error);
    }];
}

- (void)pause {
    [self.player.SHPlayer pause];
    
    NSLog(@"self.player.SHPlayer.currentPlaybackTime %f",self.player.SHPlayer.currentPlaybackTime);
}

- (void)timeScrubberChange:(UISlider*)slider {
    if (self.player.SHPlayer.duration){
        slider.maximumValue =  self.player.SHPlayer.duration;
    } else{
        slider.maximumValue = 100;
    }
    self.player.SHPlayer.currentPlaybackTime = slider.value;
}

@end
