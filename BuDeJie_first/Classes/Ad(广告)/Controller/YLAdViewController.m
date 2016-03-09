//
//  YLAdViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "YLTabBarController.h"
#import <MJExtension.h>
#import "YLAdItem.h"


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface YLAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (weak, nonatomic) IBOutlet UIView *adView;

/** 模型 */
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) YLAdItem *adItem;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YLAdViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setLaunchImage];
   
    //获取广告数据
    [self getAdData];
    
    //添加定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
// 倒计时
- (void)timeChange{
    static NSUInteger i = 3;
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%zd)",i] forState:UIControlStateNormal];
    if (i == -1) {
        [self jumpClick:nil];
    }
    i--;
}
// 获取广告数据
- (void)getAdData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [manager GET:YLADDataURL
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
             
             //[responseObject writeToFile:@"/Users/zhangyinlong/Desktop/ad.plist" atomically:YES];
             //获取模型字典
             NSDictionary *adItemDict = [responseObject[@"ad"] lastObject];
             //字典转模型
             _adItem = [YLAdItem mj_objectWithKeyValues:adItemDict];
             
             CGFloat imgW = YLScreenW;
             CGFloat imgH = YLScreenW / _adItem.w * _adItem.h;
             if (imgH > 557) {
                 imgH = 557;
             }
             self.adImageView.frame = CGRectMake(0, 0, imgW, imgH);
             [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             YLLog(@"%@",error);
         }];
}

#pragma mark - 懒加载
- (UIImageView *)adImageView{
    
    if (_adImageView == nil) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        [self.adView addSubview:adImageView];
        _adImageView = adImageView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAdImage)];
        [adImageView addGestureRecognizer:tap];
        adImageView.userInteractionEnabled = YES;
    }
    return _adImageView;
}
#pragma mark - 点击事件
// 点击广告跳转
- (void)tapAdImage{
    
    NSURL * url = [NSURL URLWithString:_adItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 点击跳转按钮
- (IBAction)jumpClick:(UIButton *)sender {
    [_timer invalidate];
    YLTabBarController *tabbarVC = [[YLTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVC;
}
#pragma mark - 设置启动图片
- (void)setLaunchImage{
    
    if (iPhone6P) {
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iPhone5){
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (iPhone4){
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}





@end
