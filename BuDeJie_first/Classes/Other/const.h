//
//  const.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - URL
/**
 *  广告链接
 */
UIKIT_EXTERN NSString * const YLADDataURL;
/**
 *  基本链接
 */
UIKIT_EXTERN NSString * const YLBaseDataURL;

#pragma mark - 数值常亮

UIKIT_EXTERN CGFloat const YLTableTopMargin;
UIKIT_EXTERN CGFloat const YLCommonMargin;
UIKIT_EXTERN CGFloat const YLTopicCellToolH;
/**
 *  NavigationBar 的高度
 */
UIKIT_EXTERN CGFloat const YLNavBarMaxY;
/**
 *  TitleView 的高度
 */
UIKIT_EXTERN CGFloat const YLTitleViewH;
/**
 *   UITabBar 的高度
 */
UIKIT_EXTERN CGFloat const YLTabBarH;
/**
 *  上拉刷新的 footerView 的高度
 */
UIKIT_EXTERN CGFloat const footerViewToRefreshH;
/**
 *  下拉刷新的 headerView 的高度
 */
UIKIT_EXTERN CGFloat const headerViewToRefreshH;

#pragma mark - 通知名
/**
 *  重复选中tabbar
 */
UIKIT_EXTERN NSString * const YLTabBarButtonDidRepeatClickNotification;
/**
 *  重复选中 titleButton
 */
UIKIT_EXTERN NSString * const YLTitleButtonDidRepeatClickNotification;

#pragma mark - 字符串常量
/**
 *  将要上拉刷新时显示的提示文字
 */
UIKIT_EXTERN NSString * const YLFooterWillRefreshText;
/**
 *  正在刷新时显示的提示文字
 */
UIKIT_EXTERN NSString * const YLFooterRefreshingText;
/**
 *  将要下拉刷新时显示的提示文字
 */
UIKIT_EXTERN NSString * const YLHeaderWillRefreshText;
/**
 *  正在刷新时显示的提示文字
 */
UIKIT_EXTERN NSString * const YLHeaderRefreshingText;









