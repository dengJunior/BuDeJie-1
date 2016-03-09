//
//  YLMeViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLMeViewController.h"
#import "YLSettingViewController.h"
#import "YLMeFooterView.h"


@interface YLMeViewController ()

@end



@implementation YLMeViewController

#pragma mark - 生命周期方法
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNavigationItem];
    //设置TableView属性
    [self setupTableView];
}
// 添加 tableview
- (void)setupTableView{
    
    self.tableView.sectionFooterHeight = YLTableTopMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(YLTableTopMargin - 35, 0, 0, 0);
    self.tableView.backgroundColor = YLColor(215, 215, 215);
    YLMeFooterView *footer = [[YLMeFooterView alloc]init];
    self.tableView.tableFooterView = footer;
    footer.backgroundColor = self.view.backgroundColor;
}
// 设置导航栏
- (void)setupNavigationItem{
    
    self.navigationItem.title = @"我的";
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *moon = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moon:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];
}
#pragma mark - 按钮点击事件
// 设置按钮点击
- (void)setting{
    
    YLSettingViewController *settingVC = [[YLSettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}
// 夜间模式
- (void)moon:(UIButton*)btn{
    
    btn.selected = !btn.selected;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *meCellID = @"MECELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:meCellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    return cell;
}









@end
