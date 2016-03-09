//
//  UIView+Frame.h
//  
//
//  Created by 张银龙 on 14/12/8.
//  Copyright © 2014年 张银龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLCategory)
@property (nonatomic, assign) CGFloat yl_width;
@property (nonatomic, assign) CGFloat yl_height;
@property (nonatomic, assign) CGFloat yl_x;
@property (nonatomic, assign) CGFloat yl_y;
@property (nonatomic, assign) CGFloat yl_centerX;
@property (nonatomic, assign) CGFloat yl_centerY;

@property (nonatomic, assign) CGFloat yl_right;
@property (nonatomic, assign) CGFloat yl_bottom;
@property (nonatomic, assign) CGSize yl_size;

+ (instancetype)loadViewFromNib;

@end
