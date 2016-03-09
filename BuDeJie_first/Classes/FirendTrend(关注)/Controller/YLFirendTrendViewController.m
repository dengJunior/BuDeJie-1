//
//  YLFirendTrendViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLFirendTrendViewController.h"
#import "YLLoginRegisterController.h"


@interface YLFirendTrendViewController ()

@end

@implementation YLFirendTrendViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationItem];
}

- (void)setupNavigationItem{
    
    self.navigationItem.title = @"我的关注";
    // 左面按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
}
#pragma mark - 按钮点击事件
- (void)friendsRecomment{
    
    
}
- (IBAction)loginClick:(UIButton *)sender {
    
    YLLoginRegisterController *loginVC = [[YLLoginRegisterController alloc]init];
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
