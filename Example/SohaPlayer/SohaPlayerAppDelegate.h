//
//  SohaPlayerAppDelegate.h
//  SohaPlayer
//
//  Created by Jackylmao on 10/27/2016.
//  Copyright (c) 2016 Jackylmao. All rights reserved.
//

@import UIKit;
#import <MdcLib/MdcLib.h>
#import "PushHandler.h"

@interface SohaPlayerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MdcLib *mdcLib;

@property (strong, nonatomic, retain) NSDate *startTime;

@property (nonatomic) UIBackgroundTaskIdentifier bgTask;


@end
