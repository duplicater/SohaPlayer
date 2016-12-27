//
//  SohaPlayerAppDelegate.m
//  SohaPlayer
//
//  Created by Jackylmao on 10/27/2016.
//  Copyright (c) 2016 Jackylmao. All rights reserved.
//

#import "SohaPlayerAppDelegate.h"

#define MDCLIB_TOKEN @"aff0466c0b9626ba3bc0deac36b01cf8"
#define MDCLIB_APPKEY @"53c213ccca20bce2d7d65c6167d0b1a6"


@interface SohaPlayerAppDelegate () <MdcLibDelegate>

@property(nonatomic, strong) PushHandler *pushHandler;

@end


@implementation SohaPlayerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"mdclibToken": MDCLIB_TOKEN}];
    NSString *mdclibToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"mdclibToken"];
    
    [self.window makeKeyAndVisible];
    
    if (mdclibToken == nil || [mdclibToken isEqualToString:@""] || [mdclibToken isEqualToString:@"YOUR_MDCLIB_PROJECT_TOKEN"]) {
#ifndef DEBUG
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"MdcLib Token Required" message:@"Go to Settings > MdcLib and add your project's token" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }]];
            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"MdcLib Token Required"
                                        message:@"Go to Settings > MdcLib and add your project's token"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
#else
        [[[UIAlertView alloc] initWithTitle:@"MdcLib Token Required"
                                    message:@"Go to Settings > MdcLib and add your project's token"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
#endif
#endif
    } else {
        // Initialize the MdcLibAPI object
        self.mdcLib = [MdcLib sharedInstanceWithToken:mdclibToken appKey:MDCLIB_APPKEY launchOptions:launchOptions];
        self.mdcLib.delegate = self;
    }
    
    // Override point for customization after application launch.
    self.mdcLib.enableRealtime = YES;
    self.mdcLib.checkForSurveysOnActive = YES;
    self.mdcLib.showSurveyOnActive = YES; //Change this to NO to show your surveys manually.
    
    self.mdcLib.checkForNotificationsOnActive = YES;
    self.mdcLib.showNotificationOnActive = YES; //Change this to NO to show your notifs manually.
    
    // Set the upload interval to 15 seconds for demonstration purposes. This would be overkill for most applications.
    self.mdcLib.flushInterval = 15; // defaults to 15 seconds
    
    self.pushHandler = [[PushHandler alloc] init];
    [MdcLib push].pushNotificationDelegate = self.pushHandler;
    
    // Set the icon badge to zero on startup (optional)
    [[MdcLib push] resetBadge];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

    NSLog(@"%@ will resign active", self);
    NSNumber *seconds = @([[NSDate date] timeIntervalSinceDate:self.startTime]);
    [[MdcLib sharedInstance] track:@"Session" properties:@{@"Length": seconds}];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.startTime = [NSDate date];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - MdcLibDelegate
- (void)updateListMesg:(NSArray *)mesg {
    NSLog(@"%@", mesg);
}

- (void)onConnected{
    NSLog(@"on Connected %@", @"ok");
}


@end
