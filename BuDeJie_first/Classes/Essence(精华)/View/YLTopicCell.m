//
//  YLTopicCell.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/28.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicCell.h"
#import "YLTopicItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+YLCategory.h"
#import "YLTopicVideoView.h"
#import "YLTopicVoiceView.h"
#import "YLTopicPictureView.h"


@interface YLTopicCell ()


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topMsgView;
@property (weak, nonatomic) IBOutlet UILabel *contentText;

/** 视频 */
@property (nonatomic, strong)  YLTopicVideoView *videoView;
/** 声音 */
@property (nonatomic, strong)  YLTopicVoiceView *voiceView;
/** 图片 */
@property (nonatomic, strong)  YLTopicPictureView *pictureView;

@end

@implementation YLTopicCell

- (YLTopicVideoView *)videoVeiw{
    
    if (_videoView == nil) {
        YLTopicVideoView *videoVeiw = [YLTopicVideoView loadViewFromNib];
        [self.contentView addSubview:videoVeiw];
        _videoView = videoVeiw;
    }
    return _videoView;
}
- (YLTopicVoiceView *)voiceView{
    
    if (_voiceView == nil) {
        YLTopicVoiceView *voiceView = [YLTopicVoiceView loadViewFromNib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (YLTopicPictureView *)pictureView{
    
    if (_pictureView == nil) {
        YLTopicPictureView *pictureView = [YLTopicPictureView loadViewFromNib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(void)awakeFromNib{
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= YLCommonMargin;
    [super setFrame:frame];
}
- (void)setItem:(YLTopicItem *)item{
    
    _item = item;
    
    UIImage *tempImage = [UIImage imageClipWithName:@"defaultUserIcon"];
    
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:tempImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
            self.profileImageView.image =[UIImage imageClipWithImage:image];
    }];
    self.nameLabel.text = item.name;
    self.timeLabel.text = item.passtime;
    self.text_label.text = item.text;
    
    // 中间部分
    switch (item.type) {
        case YLTopicCellTypeVideo:
            
            self.videoVeiw.hidden = NO;
            self.voiceView.hidden = YES;
            self.pictureView.hidden = YES;
            self.videoVeiw.item = item;
            
            break;
        case YLTopicCellTypeVoice:
            
            self.videoVeiw.hidden = YES;
            self.voiceView.hidden = NO;
            self.pictureView.hidden = YES;
            self.voiceView.item = item;
           
            break;
        case YLTopicCellTypePicture:
            
            self.videoVeiw.hidden = YES;
            self.voiceView.hidden = YES;
            self.pictureView.hidden = NO;
            self.pictureView.item = item;
            
            break;
        default:
            self.videoVeiw.hidden = YES;
            self.voiceView.hidden = YES;
            self.pictureView.hidden = YES;

            break;
    }
    
    // 最热评论
    if (item.top_cmt.count) {
        
        self.topMsgView.hidden = NO;
        NSDictionary *dict = item.top_cmt[0];
        NSString *contentText = dict[@"content"];
        NSString *username = dict[@"user"][@"username"];
        if (contentText.length == 0) { // 语音评论
            contentText = @"[语音评论]";
        }
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@",username,contentText];
        self.contentText.text = topCmtText;
        
    }else{
        
        self.topMsgView.hidden = YES;
    }
    
    // 底部评论条
    [self setButton:self.dingButton number:item.ding placeholder:@"顶"];
    [self setButton:self.caiButton number:item.cai placeholder:@"踩"];
    [self setButton:self.repostButton number:item.repost placeholder:@"转发"];
    [self setButton:self.commentButton number:item.comment placeholder:@"评论"];
    
}
- (void)setButton:(UIButton*)button number:(NSInteger)number placeholder:(NSString*)placeholder{
    
    if (number > 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1lf",number/10000.0] forState:UIControlStateNormal];
    }else if(number > 0){
        
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    switch (self.item.type) {
            
        case YLTopicCellTypeVideo:
            
            self.videoVeiw.frame = self.item.middleFrame;
            break;
        case YLTopicCellTypeVoice:

            self.voiceView.frame = self.item.middleFrame;
            break;
        case YLTopicCellTypePicture:
            
            self.pictureView.frame = self.item.middleFrame;
            break;
        default:
            break;
    }
}


@end
