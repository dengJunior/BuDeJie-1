//
//  YLButton.m
//  
//
//  Created by 张银龙 on 14/12/8.
//  Copyright © 2014年 张银龙. All rights reserved.
//

#import "YLButton.h"

@implementation YLButton


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.y = 0;
    self.imageView.frame = imageFrame;
    
    CGPoint imageCenter = self.imageView.center;
    imageCenter.x = self.frame.size.width * 0.5;
    self.imageView.center = imageCenter;
    
    CGFloat titleY = self.imageView.bounds.size.height;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(0, titleY, titleW, titleH);
    
}

- (void)awakeFromNib{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
