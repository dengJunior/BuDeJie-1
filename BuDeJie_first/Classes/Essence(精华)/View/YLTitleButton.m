//
//  YLTitleButton.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/25.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTitleButton.h"

@implementation YLTitleButton

- (void)setHighlighted:(BOOL)highlighted{}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
@end
