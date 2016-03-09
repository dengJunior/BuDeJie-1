//
//  YLMeFooterCell.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLMeFooterCell.h"
#import "YLMeFooterItem.h"
#import <UIImageView+WebCache.h>

@interface YLMeFooterCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightConstraint;


@end

@implementation YLMeFooterCell

- (void)awakeFromNib{
    
    if (iPhone5) {
        self.cellWidthConstraint.constant = 40;
        self.cellHeightConstraint.constant = 40;
    }
}
-(void)setItem:(YLMeFooterItem *)item{
    
    _item = item;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}

@end
