//
//  NSString+YLCategory.m
//  自定义cell
//
//  Created by 张银龙 on 14/12/8.
//  Copyright © 2014年 张银龙. All rights reserved.
//

#import "NSString+YLCategory.h"

@implementation NSString (YLCategory)

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

- (CGSize)sizeWithFont:(CGFloat)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self sizeWithAttributes:attrs];
}

@end
