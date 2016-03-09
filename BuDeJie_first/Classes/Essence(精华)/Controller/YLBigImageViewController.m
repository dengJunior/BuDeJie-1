//
//  YLBigImageViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/3/6.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLBigImageViewController.h"
#import "YLTopicItem.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>

#import <DALabeledCircularProgressView.h>

@interface YLBigImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *imageV;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation YLBigImageViewController

#pragma mark - 系统的 View 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
}
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}
#pragma mark - 生命周期方法
- (void)setupScrollView{
    
    CGFloat imageW = YLScreenW;
    CGFloat imageH = imageW / self.item.width * self.item.height;
    CGFloat imageY = 0;
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick:)];
    [scrollView addGestureRecognizer:tap];
    // 创建ImageView
    UIImageView *imageV = [[UIImageView alloc]init];
    self.imageV = imageV;
//    [imageV sd_setImageWithURL:[NSURL URLWithString:self.item.image1]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) return;
//        self.saveButton.enabled = YES;
//    }];
    __weak typeof(self) weakSelf = self;
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.item.image1]
                        placeholderImage:nil
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    weakSelf.progressView.hidden = NO;
                                    weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
                                    weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressView.progress * 100];
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   self.progressView.hidden = YES;
                                   if (image == nil) return;
                                   self.saveButton.enabled = YES;
                               }];
    [scrollView addSubview:imageV];
    // 设置图片显示位置
    if (imageH < YLScreenH) {
        imageY = (YLScreenH - imageH) * 0.5;
    }else{
        scrollView.contentSize = CGSizeMake(0, imageH);
    }
    imageV.frame = CGRectMake(0, imageY, imageW, imageH);
    // 缩放
    CGFloat maxScale = self.item.width / imageW;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
    
}

#pragma mark - 点击事件
- (IBAction)backClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)saveClick:(UIButton *)sender {

    [self.imageV.image yl_saveToCustomAlbumWithCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功pppp！"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageV;
}







@end
