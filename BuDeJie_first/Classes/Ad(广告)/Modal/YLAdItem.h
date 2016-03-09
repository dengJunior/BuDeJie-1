//
//  YLAdItem.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/21.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAdItem : NSObject

/** 广告图片的宽度 */
@property (nonatomic, assign) CGFloat w;
/** 广告图片的高度 */
@property (nonatomic, assign) CGFloat h;
/** 点击广告跳转的网址 */
@property (nonatomic, strong) NSString *ori_curl;
/** 广告图片 */
@property (nonatomic, strong) NSString *w_picurl;

@end
