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


@interface SohaPlayerAppDelegate ()


@end


@implementation SohaPlayerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

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
