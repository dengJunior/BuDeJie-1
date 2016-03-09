//
//  UIView+Frame.m
//  
//
//  Created by 张银龙 on 14/12/8.
//  Copyright © 2014年 张银龙. All rights reserved.
//

#import "UIView+YLCategory.h"

@implementation UIView (YLCategory)

- (void)setYl_width:(CGFloat)yl_width{
    
    CGRect bounds = self.bounds = self.bounds;
    bounds.size.width = yl_width;
    self.bounds = bounds;
}
- (CGFloat)yl_width{
    return self.bounds.size.width;
}
- (void)setYl_height:(CGFloat)yl_height{
    
    CGRect bounds = self.bounds;
    bounds.size.height = yl_height;
    self.bounds = bounds;
}
- (CGFloat)yl_height{
    
    return self.bounds.size.height;
}
- (void)setYl_x:(CGFloat)yl_x{
    
    CGRect frame = self.frame;
    frame.origin.x = yl_x;
    self.frame = frame;
}
- (CGFloat)yl_x{
    
    return self.frame.origin.x;
}
- (void)setYl_y:(CGFloat)yl_y{
    
    CGRect frame = self.frame;
    frame.origin.y = yl_y;
    self.frame = frame;
}
- (CGFloat)yl_y{
    
    return self.frame.origin.y;
}

- (void)setYl_centerX:(CGFloat)yl_centerX{
    
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}
- (CGFloat)yl_centerX{
    
    return self.center.x;
}
- (void)setYl_centerY:(CGFloat)yl_centerY{
    
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}
- (CGFloat)yl_centerY{
    
    return self.center.y;
}

- (void)setYl_right:(CGFloat)yl_right{
    
    self.yl_x = yl_right - self.yl_width;
}
- (CGFloat)yl_right{
    
    return CGRectGetMaxX(self.frame);
}
- (void)setYl_bottom:(CGFloat)yl_bottom{
    
    self.yl_y = yl_bottom - self.yl_height;
}
- (CGFloat)yl_bottom{
    
    return CGRectGetMaxY(self.frame);
}
- (void)setYl_size:(CGSize)yl_size{
    CGRect frame = self.frame;
    frame.size = yl_size;
    self.frame = frame;
}
- (CGSize)yl_size{
    return self.frame.size;
}

+ (instancetype)loadViewFromNib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];;
}



@end
