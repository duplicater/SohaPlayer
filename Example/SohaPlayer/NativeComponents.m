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

#define URL_TEST @"https://devup.sohatv.vn/play/app?v=MzQ=_OTY=_20160718_143705"

@interface NativeComponents () <NativeControlsDelegate, SHViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *playerContainer;
@property (weak, nonatomic) IBOutlet NativeControlsView *nativeControls;

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
    
    config = [[SHPlayerConfig alloc] initWithShortLinkUrl:URL_TEST appkey:nil secretKey:nil vid:nil];
    
    _player = [[SHViewController alloc] initWithConfiguration:config webRq:NO];
    
    _player.delegate = self;
    
    //set frame
    
    [_player loadPlayerIntoViewController:self];
    
    [_player.view setFrame:self.playerContainer.bounds];
    
    [self.playerContainer insertSubview:_player.view atIndex:0];
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
