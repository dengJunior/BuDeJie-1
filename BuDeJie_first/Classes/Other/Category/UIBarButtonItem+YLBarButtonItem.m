//
//  UIBarButtonItem+YLBarButtonItem.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "UIBarButtonItem+YLBarButtonItem.h"

@implementation UIBarButtonItem (YLBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action name:(NSString*)name{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithImage:(UIImage*)image selImage:(UIImage*)selImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
