//
//  UIImageView+YLCategory.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/3/3.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "UIImageView+YLCategory.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@implementation UIImageView (YLCategory)


- (void)setImageBDImage:(NSString*)BDImage andNormalImage:(NSString *)normalImage placholder:(UIImage *)placholder{
    // 先检查缓存中有没有大图
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:BDImage];
    if (cacheImage) {
        self.image = cacheImage;
    }else{
        
        [self sd_setImageWithURL:[NSURL URLWithString:BDImage] placeholderImage:placholder];
        //分网络状态显示不同品质图片
        /*
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        switch (manager.networkReachabilityStatus) {
                
            case AFNetworkReachabilityStatusReachableViaWWAN:// 手机网
                [self sd_setImageWithURL:[NSURL URLWithString:normalImage] placeholderImage:placholder] ;
                NSLog(@"手机网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:// WiFi
                [self sd_setImageWithURL:[NSURL URLWithString:BDImage] placeholderImage:placholder];
                NSLog(@"WiFi");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:// 没网
                self.image = placholder;
                NSLog(@"没网");
                break;
            case AFNetworkReachabilityStatusUnknown://
                self.image = placholder;
                NSLog(@"不知道");
                break;
            default:
                
                break;
        }
        [manager startMonitoring];
        */
    }
}
@end
