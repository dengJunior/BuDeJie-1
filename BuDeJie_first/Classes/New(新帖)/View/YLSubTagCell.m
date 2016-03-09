//
//  YLSubTagCell.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/21.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLSubTagCell.h"
#import <UIImageView+WebCache.h>
#import "YLSubTagItem.h"


@interface YLSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end


@implementation YLSubTagCell

//点击订阅按钮
- (IBAction)takeBtnClick:(UIButton *)button {
    
    button.selected = !button.selected;
}
- (void)setItem:(YLSubTagItem *)item{
    
    _item = item;
    
    UIImage *tempImage = [UIImage imageClipWithName:@"defaultUserIcon"];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:tempImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.iconImageView.image = [UIImage imageClipWithImage:image];
    }];
    
    self.nameLabel.text = item.theme_name;
    self.numLabel.text = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    CGFloat numF = [item.sub_number integerValue];
    if (numF > 10000) {
        
        self.numLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",numF / 10000.0];
    }
}
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
-(void)awakeFromNib{
    
    //self.layoutMargins = UIEdgeInsetsZero;
}

@end
