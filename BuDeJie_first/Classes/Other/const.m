//
//  const.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "const.h"

#pragma mark - URL
/**
 *  广告链接
 */
NSString * const YLADDataURL = @"http://mobads.baidu.com/cpro/ui/mads.php";
/**
 *  基本链接
 */
NSString * const YLBaseDataURL = @"http://api.budejie.com/api/api_open.php";

#pragma mark - 数值常亮
CGFloat const YLTableTopMargin = 10;
CGFloat const YLCommonMargin = 10;
CGFloat const YLTopicCellToolH = 35;
/**
 *  NavigationBar 的高度
 */
CGFloat const YLNavBarMaxY = 64;
/**
 *  TitleView 的高度
 */
CGFloat const YLTitleViewH = 30;
/**
 *   UITabBar 的高度
 */
CGFloat const YLTabBarH = 49;
/**
 *  上拉刷新的 footerView 的高度
 */
CGFloat const footerViewToRefreshH = 35;
/**
 *  下拉刷新的 headerView 的高度
 */
CGFloat const headerViewToRefreshH = 50;

#pragma mark - 通知名
NSString * const YLTabBarButtonDidRepeatClickNotification = @"YLTabBarButtonDidRepeatClickNotification";
NSString * const YLTitleButtonDidRepeatClickNotification = @"YLTitleButtonDidRepeatClickNotification";

#pragma mark - 字符串常量
NSString * const YLFooterWillRefreshText = @"上拉加载更多数据";
NSString * const YLFooterRefreshingText = @"正在加载数据...";
NSString * const YLHeaderWillRefreshText = @"下拉加载更多数据";
NSString * const YLHeaderRefreshingText = @"正在加载数据...";






