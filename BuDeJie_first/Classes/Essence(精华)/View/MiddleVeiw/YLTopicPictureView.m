//
//  YLTopicPictureView.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/29.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "YLTopicItem.h"
#import <AFNetworking.h>
#import "YLBigImageViewController.h"
#import <DALabeledCircularProgressView.h>

@interface YLTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPic;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation YLTopicPictureView

- (void)awakeFromNib{
    
    self.pictureView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage:)];
    [self.pictureView addGestureRecognizer:tap];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}
- (void)seeBigImage:(YLTopicItem *)item{
    
    YLBigImageViewController *bigImageVC = [[YLBigImageViewController alloc]init];
    bigImageVC.item = self.item;
    UIViewController *vc = self.window.rootViewController;
    [vc presentViewController:bigImageVC animated:YES completion:^{
        
    }];
    
}
- (void)setItem:(YLTopicItem *)item{
    
    _item = item;
    
    __weak typeof(self) weakSelf = self;
    
    //[self.pictureView setImageBDImage:item.image1 andNormalImage:item.image0 placholder:nil];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image1]
                        placeholderImage:nil
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    weakSelf.progressView.hidden = NO;
                                    weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
                                    weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressView.progress * 100];
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    self.progressView.hidden = YES;
                               }];
    
    self.gif.hidden = !item.is_gif;
    [self bringSubviewToFront:self.gif];
    
    if (item.isBigImage) {
        
        self.seeBigPic.hidden = NO;
        self.pictureView.contentMode = UIViewContentModeTop;
        self.pictureView.clipsToBounds = YES;
    }else{
        
        self.seeBigPic.hidden = YES;
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
        self.pictureView.clipsToBounds = NO;
    }
    
}


@end
