//
//  AppDelegate.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 15/8/27.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "BaseNavController.h"
#import "LeftViewController.h"
#import "LaunchViewController.h"
#import "ZDRootViewController.h"

#import "ZDHomeViewController.h"
#import "ZDThemeViewController.h"
#import "ZDLaunchAdvertiseView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[ZDRootViewController alloc] init];
    
    ZDLaunchAdvertiseView *launchView = [[ZDLaunchAdvertiseView alloc] initWithFrame:self.window.bounds];
    [launchView startLaunch];
    
    [[Routable sharedRouter] map:@"home" toController:[ZDHomeViewController class]];
    [[Routable sharedRouter] map:@"theme" toController:[ZDThemeViewController class]];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end