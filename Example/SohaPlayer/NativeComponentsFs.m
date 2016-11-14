//
//  NativeComponentsFs.m
//  SohaPlayerDemo
//
//  Created by Le Cuong on 10/18/16.
//  Copyright © 2016 Le Cuong. All rights reserved.
//

#import "NativeComponentsFs.h"
#import <SohaPlayer/SHViewController.h>

#define URL_TEST @"http://www.streambox.fr/playlists/x36xhzz/x36xhzz.m3u8"


@interface NativeComponentsFs ()

@property (retain, nonatomic) SHViewController *player;

@end

@implementation NativeComponentsFs

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SHViewController *)player {
    if (!_player) {
        
        // Account Params
        SHPlayerConfig *config = [[SHPlayerConfig alloc] initWithSourceUrl:URL_TEST appkey:nil secretKey:nil vid:nil];

        
        _player = [[SHViewController alloc] initWithConfiguration:config webRq:NO];
        
        [_player setShowControls:YES];
    }
    return _player;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //Present view controller - inline view
    //    self.player.view.frame = (CGRect){0, 0, 320, 180};
    //    [self.player loadPlayerIntoViewController:self];
    //    [self.view addSubview:_player.view];
    //Present view controller - Fullscreen view
    [self presentViewController:self.player animated:YES completion:nil];
    [self.player.SHPlayer play];
}

@end
