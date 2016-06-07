//
//  AppDelegate.m
//  PocketNews
//
//  Created by FengXu on 16/5/3.
//  Copyright (c) 2016年 FengXu. All rights reserved.
//

#import "AppDelegate.h"
#import "TopViewController.h"
#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "DrawerViewController.h"
#import "ParentViewController.h"
#import "UMSocial.h"

@interface AppDelegate () {
    UMSocialAccountEntity * snsAccount;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [UMSocialData setAppKey:kUMKeyString];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:18 forKey:@"size"];
    [defaults setObject:@"夜间模式" forKey:@"modeName"];
    [defaults setObject:@"nightmode" forKey:@"modeImage"];;
    
    //是否授权腾讯微博
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent] || [UMSocialAccountManager isOauthWithPlatform:UMShareToSina]) {
        //已授权登陆
        NSLog(@"已授权！！！%@",[defaults objectForKey:@"iconUrl"]);
    }
    else{
        [defaults setObject:@"login_tip" forKey:@"iconUrl"];
        [defaults setObject:@"..." forKey:@"userName"];
        [defaults setObject:@"登陆后，头条分享与微博互动更便捷！" forKey:@"profileURL"];
        NSLog(@"未授权！！！%@",[defaults objectForKey:@"iconUrl"]);
    }
    [defaults synchronize];
    
    
    LeftViewController *LeftVC = [[LeftViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:LeftVC ];
    
    TopViewController *CenterVC = [[TopViewController alloc] init];
    UINavigationController *NavigationVC = [[UINavigationController alloc] initWithRootViewController:CenterVC];
    
    RightViewController *RightVC = [[RightViewController alloc] init];
    
    DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:nvc centerViewController:NavigationVC rightViewController:RightVC];
    self.window.rootViewController = DrawerVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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
