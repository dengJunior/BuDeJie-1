//
//  YLTabBarItem.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLTabBar.h"
#import "YLPublishViewController.h"

@interface YLTabBar ()

/** 发布按钮 */
@property (nonatomic, weak) UIButton *plusBtn;

/** 当前选中的按钮的tag值 */
@property (nonatomic, assign) NSInteger selectedBtnTag;

@end

@implementation YLTabBar

#pragma mark - view
+ (void)load{
    //更改TabBarItem字体颜色
    [self setAttributesTitleColor];
}

- (UIButton *)plusBtn{
    
    if (_plusBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [btn sizeToFit];
        _plusBtn = btn ;
        [self addSubview:btn];
    }
    return _plusBtn;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    NSInteger count = self.items.count + 1 ;
    CGFloat btnW = self.yl_width / count;
    CGFloat btnH = self.yl_height;
    NSInteger i = 0;
    for (UIButton *tabBarButton in self.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i += 1;
            }
            CGFloat btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            tabBarButton.tag = i;
            i++;
            
            //添加点击事件
            [tabBarButton addTarget:self action:@selector(tabBarButtonRepeatClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusBtn.center = CGPointMake(self.yl_width * 0.5 , self.yl_height * 0.5);
    //不能这么设置,坐标系不对
    //self.plusBtn.center = CGPointMake(self.yl_centerX , self.yl_centerY);
    //YLLog(@"%lf,%lf",self.yl_centerX,self.yl_centerY);//187.500000,642.500000
}
#pragma mark - 点击事件处理
- (void)plusBtnClick{
    
    YLPublishViewController *pushVC = [[YLPublishViewController alloc]init];
    
    [self.window.rootViewController presentViewController:pushVC animated:YES completion:^{
        
    }];
}
- (void)tabBarButtonRepeatClick:(UIButton *)button{
    
    if (self.selectedBtnTag == button.tag) {
        //发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:YLTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.selectedBtnTag = button.tag;
}
#pragma mark - 更改TabBarItem字体颜色
+ (void)setAttributesTitleColor{
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //更改普通状态下字体
    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    normal[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:normal forState:UIControlStateNormal];
    //更改选中状态下的颜色
    NSMutableDictionary *select = [NSMutableDictionary dictionary];
    select[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:select forState:UIControlStateSelected];
}
@end
