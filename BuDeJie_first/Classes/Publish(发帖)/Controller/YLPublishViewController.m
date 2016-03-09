//
//  YLPublishViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLPublishViewController.h"
#import <CTAssetsPickerController.h>
#import <Photos/Photos.h>
#import "YLButton.h"
#import <POP.h>

static CGFloat const YLSpringValue = 10;

@interface YLPublishViewController ()<CTAssetsPickerControllerDelegate>

@property (nonatomic, weak) UIImageView *sloganView;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation YLPublishViewController

- (NSMutableArray *)buttons{
    
    if (_buttons == nil) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YLColor(215, 215, 215);
    
    [self setupButtons];
    
    [self setupSlogan];
    
}

#pragma mark - 生命周期方法
- (void)setupButtons{
    
    NSArray *btnImages = @[@"publish-video",
                           @"publish-picture",
                           @"publish-text",
                           @"publish-audio",
                           @"publish-review",
                           @"publish-offline",
                           ];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发语音",@"审帖",@"离线"];
    CGFloat btnW = YLScreenW / 3;
    CGFloat btnH = btnW;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    NSInteger row,col;
    CGFloat offset = (YLScreenH - btnH * 2) / 2;
    for (NSInteger i = 0; i < titles.count; i++) {
        YLButton *btn = [[YLButton alloc]init];
        // 第几行,第几列
        row = i / 3;
        col = i % 3;
        btnX = btnW * col;
        btnY = btnH * row + offset;
        //btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [self.buttons addObject:btn];
        // 动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY - YLScreenH, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        
        anim.springSpeed = YLSpringValue;
        anim.springBounciness = YLSpringValue;
        anim.beginTime = CACurrentMediaTime() + ((titles.count - i) * 0.1);
        [btn pop_addAnimation:anim forKey:nil];
    }
}

- (void)setupSlogan{
    
    CGFloat sloganY = YLScreenH * 0.2;
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.yl_y = sloganY - YLScreenH;
    sloganView.yl_centerX = YLScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    anim.toValue = @(sloganY);
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.beginTime = CACurrentMediaTime() + 0.7;
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
// 退出
- (void)exit{
    
    // button 退出动画
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        
        YLButton *btn = self.buttons[i];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(btn.layer.position.y + YLScreenH);
        anim.springSpeed = YLSpringValue;
        anim.springBounciness = YLSpringValue;
        anim.beginTime = CACurrentMediaTime() + ((self.buttons.count - i) * 0.1);
        
        [btn pop_addAnimation:anim forKey:nil];
    }
    // sloganView 退出动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.layer.position.y + YLScreenH);
    anim.springSpeed = YLSpringValue;
    anim.springBounciness = YLSpringValue;
    anim.beginTime = CACurrentMediaTime() + 0.7;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
    [self.sloganView pop_addAnimation:anim forKey:nil];
}

#pragma mark - 点击事件
- (void)buttonClicked:(YLButton*)button{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            CTAssetsPickerController * picker = [[CTAssetsPickerController alloc]init];
            picker.delegate = self;
            picker.assetCollectionSubtypes = @[
                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                               @(PHAssetCollectionSubtypeAlbumRegular)
                                               ];
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        });
    }];
}

#pragma mark - CTAssetsPickerControllerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    // 展示照片
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self exit];
}

@end
