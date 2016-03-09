//
//  UIBarButtonItem+YLBarButtonItem.h
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YLBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage*)image selImage:(UIImage*)selImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action name:(NSString*)name;
@end
