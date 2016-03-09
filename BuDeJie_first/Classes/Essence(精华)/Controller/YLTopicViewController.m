//
//  YLTopicViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/3/3.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "YLTopicCell.h"
#import <MJRefresh.h>


@interface YLTopicViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 模型数组 */
@property (nonatomic, strong)  NSMutableArray *topics;
/** 最后一组数据 */
@property (nonatomic, copy) NSString * maxTime;

@end

@implementation YLTopicViewController

static NSString * const ID = @"cell";

#pragma mark - 生命周期方法
- (YLTopicCellType)type{
    return 0;
}
- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    // 设置TableVeiw相关
    [self setupTableVeiw];
    // 添加观察者
    [self addNotificationObserver];
    // 添加刷新控件
    [self setupViewToRefresh];
    
}
- (void)setupTableVeiw{
    
    self.tableView.backgroundColor = YLColor(215, 215, 215);
    self.tableView.contentInset = UIEdgeInsetsMake(YLNavBarMaxY+YLTitleViewH, 0, YLTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.estimatedRowHeight = 160;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
// 添加刷新控件
- (void)setupViewToRefresh{
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark - 获取数据
// 获取最新的帖子
- (void)loadNewTopics {
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.manager GET:YLBaseDataURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[responseObject writeToFile:@"/Users/zhangyinlong/Desktop/a.plist" atomically:YES];
        // 字典转模型
        self.topics = [YLTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YLLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}
// 获取更多的帖子
- (void)loadMoreTopics{
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxTime;
    
    [self.manager GET:YLBaseDataURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxTime = responseObject[@"info"][@"maxtime"];
        NSArray *array = [YLTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:array];
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        YLLog(@"%@",error);
    }];
}
#pragma mark - 通知
// 添加观察者
- (void)addNotificationObserver{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivedNotification) name:YLTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivedNotification) name:YLTitleButtonDidRepeatClickNotification object:nil];
}
// 收到通知
- (void)receivedNotification{
    
    if (!self.tableView.scrollsToTop) return;
    if (self.tableView.window == nil) return;
    [self.tableView.mj_header beginRefreshing];
}
// 移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.topics.count == 0)
        self.tableView.mj_footer.hidden = YES;
    
    return self.topics.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    YLTopicItem *item = self.topics[indexPath.row];
    [item cellHeight];
    cell.item = item;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YLTopicItem *item = self.topics[indexPath.row];
    
    return item.cellHeight;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [[SDImageCache sharedImageCache] clearMemory];

}



@end
