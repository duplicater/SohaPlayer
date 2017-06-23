//
//  SohaPlayerAppDelegate.h
//  SohaPlayer
//
//  Created by Jackylmao on 10/27/2016.
//  Copyright (c) 2016 Jackylmao. All rights reserved.
//

@import UIKit;

@interface SohaPlayerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic, retain) NSDate *startTime;

@property (nonatomic) UIBackgroundTaskIdentifier bgTask;


@end
