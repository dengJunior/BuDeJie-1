//
//  YLTopicViewController.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/3/3.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTopicItem.h"

@interface YLTopicViewController : UITableViewController
// 写这个方法声明：仅仅是为了点语法有智能提示
- (YLTopicCellType)type;
@end
