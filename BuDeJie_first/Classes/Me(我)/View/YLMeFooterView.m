//
//  YLMeFooterView.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YLMeFooterItem.h"
#import "YLMeFooterCell.h"
#import "YLWebViewController.h"


static NSString * const ID = @"cell";
static CGFloat const minMargin = 1;
static NSInteger const cols = 4;

#define YLMeFooterCellWH ((YLScreenW - (cols - 1) * minMargin) / cols)

@interface YLMeFooterView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YLMeFooterView

- (instancetype)init{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, YLScreenW, 300)]) {
        [self loadData];
        [self setupCollectionView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];//- 行数 = (总数  - 1) / 列数 + 1
    //self.yl_height = ((_items.count - 1)/cols + 1) * YLMeFooterCellWH;
    
}
- (void)setupCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(YLMeFooterCellWH, YLMeFooterCellWH);
    
    layout.minimumInteritemSpacing = minMargin;
    layout.minimumLineSpacing = minMargin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = self.backgroundColor;
    //注册 cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLMeFooterCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}
- (void)loadData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:YLBaseDataURL
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
             
             //[responseObject writeToFile:@"/Users/zhangyinlong/Desktop/me.plist" atomically:YES];
             _items = [YLMeFooterItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
             [self.collectionView reloadData];
             
             self.yl_height = ((_items.count - 1) / cols + 1) * YLMeFooterCellWH;
             
             _collectionView.frame = self.bounds;
             
             UITableView *tableView = (UITableView *)self.superview;
             tableView.tableFooterView = self;
             [tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YLLog(@"%@",error);
         }];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLMeFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.items[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLMeFooterItem *item = self.items[indexPath.row];
    YLWebViewController *webVC = [[YLWebViewController alloc]init];
    
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVc.selectedViewController;
    webVC.url = item.url;
    if ([item.url hasPrefix:@"http"]) {
        webVC.navigationItem.title = item.name;
        [nav pushViewController:webVC animated:YES];
    }
}


@end
