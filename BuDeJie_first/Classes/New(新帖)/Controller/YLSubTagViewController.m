//
//  YLTagSubViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/21.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLSubTagViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YLSubTagItem.h"
#import "YLSubTagCell.h"

static NSString * const subTagID = @"subTagCell";

@interface YLSubTagViewController ()

@property (nonatomic, weak)  AFHTTPSessionManager *manager;
@property (nonatomic, strong)  NSArray *items;

@end

@implementation YLSubTagViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐订阅";
    //获取标签数据
    [self getTagData];
    //注册 cell
    [self.tableView registerNib: [UINib nibWithNibName:NSStringFromClass([YLSubTagCell class]) bundle:nil] forCellReuseIdentifier:subTagID];
    
    //self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = YLColor(215, 215, 215);
    
    //不要系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.labelText = @"正在加载.......";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
#pragma mark - 获取标签数据
- (void)getTagData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _manager = manager;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    [manager GET:YLBaseDataURL
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        
             //[responseObject writeToFile:@"/Users/zhangyinlong/Desktop/tag.plist" atomically:YES];
             self.items = [YLSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
             // 刷新表格
             [self.tableView reloadData];
             
             [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YLLog(@"%@",error);
             [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
    }];
    
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:subTagID];
    cell.item = self.items[indexPath.row];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

@end
