//
//  YLTopicItem.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/28.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicItem.h"
#import "NSString+YLCategory.h"

@implementation YLTopicItem

- (CGFloat)cellHeight{
    
    
    if (_cellHeight) return _cellHeight;
    
    _cellHeight = 0;
    // 头像
    _cellHeight += 55;
    // 文字
    CGSize maxSize = CGSizeMake(YLScreenW - 2 * YLCommonMargin,MAXFLOAT);
    CGFloat textHeight = [self.text sizeWithFont:15 maxSize:maxSize].height;
    _cellHeight += textHeight + YLCommonMargin;
    
    // 中间内容
    if (self.type != YLTopicCellTypeWord) {
        
        // 如果不是纯文字,计算中间内容的高度
        CGFloat middleW = YLScreenW - 2 * YLCommonMargin;
        CGFloat middleH = middleW / self.width * self.height;
        if (middleH >= YLScreenH) {
            self.isBigImage = YES;
            middleH = 350;
        }
        CGFloat middleX = YLCommonMargin;
        CGFloat middleY = _cellHeight;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += middleH + YLCommonMargin;
    }
    //最热评论
    if (self.top_cmt.count) {// 如果有最热有最热评论
        
        _cellHeight += 18;
        
        NSDictionary *dict = self.top_cmt[0];
        NSString *contentText = dict[@"content"];
        NSString *username = dict[@"user"][@"username"];
        if (contentText.length == 0) { // 语音评论
            contentText = @"[语音评论]";
        }
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@",username,contentText];
        
        CGFloat contentTextH = [topCmtText sizeWithFont:15 maxSize:maxSize].height;
        _cellHeight += contentTextH + YLCommonMargin;
        
    }
    
    
    // 工具栏
    _cellHeight += YLTopicCellToolH + YLCommonMargin;
    
    return _cellHeight;
}



@end
