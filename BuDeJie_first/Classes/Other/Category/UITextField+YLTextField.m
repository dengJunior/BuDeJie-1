//
//  UITextField+YLTextField.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "UITextField+YLTextField.h"

@implementation UITextField (YLTextField)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.color"];
}

- (UIColor *)placeholderColor{
    
    return [self valueForKeyPath:@"placeholderLabel.color"];
}

@end
