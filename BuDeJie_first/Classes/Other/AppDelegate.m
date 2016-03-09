//
//  AppDelegate.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "AppDelegate.h"
#import "YLTabBarController.h"
#import "YLAdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 设置根控制器
    //self.window.rootViewController = [[YLTabBarController alloc]init];
    self.window.rootViewController = [[YLAdViewController alloc]init];
    // 显示根控制器
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
