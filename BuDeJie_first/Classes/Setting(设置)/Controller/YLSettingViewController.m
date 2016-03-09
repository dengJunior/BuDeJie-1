//
//  YLSettingViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLSettingViewController.h"
#import "YLCacheManager.h"

@interface YLSettingViewController ()

@property (nonatomic, assign) NSInteger totalSize;


@end

@implementation YLSettingViewController

#pragma mark - 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];

    //设置导航栏
    [self setupNavigationItem];
    
    self.tableView.backgroundColor = YLColor(215, 215, 215);
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(YLTableTopMargin - 35, 0, 0, 0);
    
    //添加指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.labelText = @"正在计算缓存";
    hud.removeFromSuperViewOnHide = YES;
    // 获取缓存大小
    [YLCacheManager getCacheSizeCompletion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [hud hide:YES];
        [self.tableView reloadData];
    }];
    
}
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
// 设置导航栏
- (void)setupNavigationItem{
    
    self.navigationItem.title= @"设置";
}
#pragma mark - 计算显示的缓存数据
- (NSString *)cacheStr{
    
    NSString *str = @"清除缓存";
    if (_totalSize > 1000 * 1000) {
        
        CGFloat sizeMB = _totalSize / (1000 * 1000);
        str = [NSString stringWithFormat:@"%@(%.1lfMB)",str,sizeMB];
    }else if (_totalSize > 1000){
        
        CGFloat sizeKB = _totalSize / 1000;
        str = [NSString stringWithFormat:@"%@(%.1lfKB)",str,sizeKB];
        
    }else if (_totalSize < 1000){
        
        str = [NSString stringWithFormat:@"%@(%.ldB)",str,_totalSize];
        
    }else if (_totalSize == 0){
        
        str = [NSString stringWithFormat:@"干干净净,洁癖晚期"];
        
    }
    return str;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * const cellID = @"meCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"测试";
    }else{
        
        cell.textLabel.text = [self cacheStr];
        
    }
    
    return cell;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在清除,请稍等";
        hud.removeFromSuperViewOnHide = YES;
        [YLCacheManager removeCacheDataCompletion:^{
            _totalSize = 0;
            hud.labelText = @"已经清除缓存了";
            [hud hide:YES afterDelay:0.5];
            hud.mode = MBProgressHUDModeText;
            [self.tableView reloadData];
        }];
    }
}
@end
