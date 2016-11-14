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

#import <AVFoundation/AVFoundation.h>

//#define URL_TEST @"http://hls.vcmedia.vn/kenh14/bzr5ienedy-xge47jt5qgx8sd3mcsu/2016/11/10/cauhon-bongda-1478773085927-eda5d.mp4"
#define URL_TEST @"http://www.streambox.fr/playlists/x36xhzz/x36xhzz.m3u8"

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
    
    config = [[SHPlayerConfig alloc] initWithSourceUrl:URL_TEST appkey:nil secretKey:nil vid:nil];
    
    _player = [[SHViewController alloc] initWithConfiguration:config webRq:NO];
    
    _player.delegate = self;
    
    [_player loadPlayerIntoViewController:self];
    
    [_player.view setFrame:self.playerContainer.bounds];
    
    [self.playerContainer insertSubview:_player.view atIndex:0];
    
    /*
    _item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:URL_TEST]];
    _avPlayer = [[AVPlayer alloc] initWithPlayerItem:_item];
    
    _layerPlay = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    
    [_layerPlay setFrame:self.playerContainer.bounds];
    
    //[_layerPlay setPlayer:_avPlayer];
    
    [_avPlayer play];
    
    [self.playerContainer.layer addSublayer:_layerPlay];
    */
    
//    [_player addSHPlayerEventListener:@"durationChange" eventID:@" id_1" handler:^(NSString *eventName, NSString *params) {
//        ///new duration value
//        
//        NSLog(@"event nname %@ \n params %@",eventName,params);
//    }];
//    
//    
//    [_player addSHPlayerEventListener:@"rootResize" eventID:@"face_id_2" handler:^(NSString *eventName, NSString *params) {
//        /// the player parent was resized
//        
//        NSLog(@"event nname %@ \n params %@",eventName,params);
//    }];
    
}

- (void)updateCurrentPlaybackTime:(double)currentPlaybackTime{
    NSLog(@"updateCurrentPlaybackTime: %f",currentPlaybackTime);
    
    [_nativeControls.progressSlider setValue:currentPlaybackTime];
}

- (void)SHPlayer:(SHViewController*)player playerLoadStateDidChange:(SHMediaLoadState)state
{
    NSLog(@"playerLoadStateDidChange %lu",(unsigned long)state);
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
