//
//  YLLoginTextField.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLLoginTextField.h"

@implementation YLLoginTextField

- (void)awakeFromNib{

    self.tintColor = [UIColor whiteColor];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"placeholderLabel.color"];
}

- (BOOL)becomeFirstResponder{
    
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.color"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"placeholderLabel.color"];
    return [super resignFirstResponder];
}
@end
