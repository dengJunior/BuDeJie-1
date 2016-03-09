//
//  YLLoginRegisterController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/21.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLLoginRegisterController.h"
#import "YLFastLoginView.h"


@interface YLLoginRegisterController ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation YLLoginRegisterController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    YLFastLoginView *fastLoginView = [YLFastLoginView loadViewFromNib];
    [_bottomView addSubview:fastLoginView];
    
}
- (void)viewDidLayoutSubviews{
    
    UIView *fastLoginView = _bottomView.subviews[0];
    fastLoginView.frame = CGRectMake(0, 0, _bottomView.yl_width, _bottomView.yl_height);
    
    self.widthConstraint.constant = self.view.yl_width;
}
#pragma mark - 按钮点击事件
// 关闭
- (IBAction)closeClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 注册/已有帐号
- (IBAction)loginOrRegister:(UIButton *)button {
    
    [self.view endEditing:YES];
    button.selected = !button.selected;
    
    _leftConstraint.constant = _leftConstraint.constant == 0 ? -YLScreenW : 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

// 点击登录按钮
- (IBAction)loginBtnClick:(UIButton *)button {
    
    [self.view endEditing:YES];
    if ([button.currentTitle isEqualToString:@"登录"]) {
        YLLog(@"点击了登录按钮");
    }else if([button.currentTitle isEqualToString:@"注册"]){
        YLLog(@"点击了注册按钮");
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
