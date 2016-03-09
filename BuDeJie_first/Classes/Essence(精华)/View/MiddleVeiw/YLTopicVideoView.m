//
//  YLTopicVideoView.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/29.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "YLTopicItem.h"
#import "YLBigImageViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface YLTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *videotime;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (nonatomic, strong) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end

@implementation YLTopicVideoView

- (void)awakeFromNib{
    
    self.videoView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playButtonClock:)];
    [self.videoView addGestureRecognizer:tap];
}
- (IBAction)playButtonClock:(UIButton *)button {
    
    // 1.获取URL(远程/本地)
    NSURL *url = [NSURL URLWithString:self.item.videouri];
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    // 3.创建AVPlayer
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    // 4.添加AVPlayerLayer
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playLayer.frame = self.videoView.bounds;
    
    [self.videoView.layer addSublayer:playLayer];
    
    [self.player play];
    self.playButton.hidden = YES;
}

- (void)setItem:(YLTopicItem *)item{
    
    _item = item;
    
    [self.videoView setImageBDImage:item.image1 andNormalImage:item.image0 placholder:nil];
    
    self.videotime.text = [NSString stringWithFormat:@"%02zd:%02zd",item.videotime / 60,item.videotime % 60];
    self.playcount.text = [NSString stringWithFormat:@"%zd播放",item.playcount];
}

@end
