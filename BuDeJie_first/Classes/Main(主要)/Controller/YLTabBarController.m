//
//  YLTabBarController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTabBarController.h"
#import "YLFirendTrendViewController.h"
#import "YLEssenceViewController.h"
#import "YLNavigationController.h"
#import "YLNewViewController.h"
#import "YLMeViewController.h"
#import "YLTabBar.h"

@interface YLTabBarController ()

@end

@implementation YLTabBarController

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所有控制器
    [self setupAllViewController];
    //替换 tabbar
    [self setupTabBar];
}

- (void)setupTabBar{
    
    [self setValue:[[YLTabBar alloc]init] forKeyPath:@"tabBar"];
}
// 添加所有控制器
- (void)setupAllViewController{
    
    // 精华
    YLEssenceViewController *essenceVC = [[YLEssenceViewController alloc]init];
    [self setupOneViewController:essenceVC
                           image:[UIImage imageOriginalName:@"tabBar_essence_icon"]
                     selectImage:[UIImage imageOriginalName:@"tabBar_essence_click_icon"]
                           title:@"精华"];
    // 新帖
    YLNewViewController *newVC = [[YLNewViewController alloc]init];
    [self setupOneViewController:newVC
                           image:[UIImage imageOriginalName:@"tabBar_new_icon"]
                     selectImage:[UIImage imageOriginalName:@"tabBar_new_click_icon"]
                           title:@"新帖"];
    // 关注
    YLFirendTrendViewController *firendTrendVC = [[YLFirendTrendViewController alloc]init];
    [self setupOneViewController:firendTrendVC
                           image:[UIImage imageOriginalName:@"tabBar_friendTrends_icon"]
                     selectImage:[UIImage imageOriginalName:@"tabBar_friendTrends_click_icon"]
                           title:@"关注"];
    // 我
    YLMeViewController *meVC = [[YLMeViewController alloc]init];
    [self setupOneViewController:meVC
                           image:[UIImage imageOriginalName:@"tabBar_me_icon"]
                     selectImage:[UIImage imageOriginalName:@"tabBar_me_click_icon"]
                           title:@"我"];
}
// 添加单个控制器
- (void)setupOneViewController:(UIViewController*)vc image:(UIImage*)image selectImage:(UIImage*)selectImage title:(NSString*)title{
    
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:vc] ;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    vc.tabBarItem.title = title;
    
    [self addChildViewController:nav];
}




@end
