//
//  YLNewViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLNewViewController.h"
#import "YLSubTagViewController.h"


@interface YLNewViewController ()

@end

@implementation YLNewViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YLColor(215, 215, 215);
    
    //设置导航栏
    [self setupNavigationItem];
    
}

// 设置导航栏
- (void)setupNavigationItem{
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左面按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagSubIcon)];
}
#pragma mark - 按钮点击事件
// 左面按钮点击
- (void)tagSubIcon{
    
    YLSubTagViewController *subTagVC = [[YLSubTagViewController alloc]init];
    [self.navigationController pushViewController:subTagVC animated:YES];
    
}



@end
