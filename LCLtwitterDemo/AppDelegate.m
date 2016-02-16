//
//  AppDelegate.m
//  LCLtwitterDemo
//
//  Created by liaochenliang on 16-2-15.
//  Copyright (c) 2016年 liaochenliang. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *VC = [[MainViewController alloc]init];
    UINavigationController * navMainC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = navMainC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
