//
//  YLTopicItem.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/28.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTopicItem : NSObject

typedef NS_ENUM(NSUInteger ,YLTopicCellType){
    
    YLTopicCellTypeALL = 1,
    YLTopicCellTypePicture = 10,
    YLTopicCellTypeWord = 29,
    YLTopicCellTypeVoice = 31,
    YLTopicCellTypeVideo = 41
};

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/**************** 中间 View ***********************/
/********** 图片 *********/

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 是否是 GIF */
@property (nonatomic, assign) BOOL is_gif;


/********** 视频 *********/

/** 时长 */
@property (assign, nonatomic) NSInteger videotime;
/** 播放次数 */
@property (assign, nonatomic) NSInteger playcount;
/** 视频地址 */
@property (nonatomic, copy) NSString *videouri;

/********** 图片 *********/

/** 宽 */
@property (nonatomic, assign) CGFloat width;
/** 高 */
@property (nonatomic, assign) CGFloat height;



/** 类型 */
@property (nonatomic, assign) YLTopicCellType type;

/** 模型存着 cell 的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect middleFrame;
/** 是否是长图 */
@property (nonatomic, assign) BOOL isBigImage;

@end
