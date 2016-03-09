//
//  YLTopicVoiceView.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/29.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "YLTopicItem.h"
#import "YLBigImageViewController.h"

@interface YLTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *voiceView;

@end

@implementation YLTopicVoiceView

- (void)awakeFromNib{
    
    self.voiceView.userInteractionEnabled = YES;
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage:)];
    //[self.voiceView addGestureRecognizer:tap];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)seeBigImage:(YLTopicItem *)item{
    
    YLBigImageViewController *bigImageVC = [[YLBigImageViewController alloc]init];
    bigImageVC.item = self.item;
    UIViewController *vc = self.window.rootViewController;
    [vc presentViewController:bigImageVC animated:YES completion:^{}];
}
- (IBAction)playButtonClick:(UIButton*)button {
    
    button.selected = !button.selected;
}

- (void)setItem:(YLTopicItem *)item{
    
    _item = item;

    [self.voiceView setImageBDImage:item.image1 andNormalImage:item.image0 placholder:nil];
  
}
@end
