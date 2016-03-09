//
//  YLEssenceViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/18.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLEssenceViewController.h"
#import "YLTitleButton.h"
#import "YLAllViewController.h"
#import "YLVideoViewController.h"
#import "YLVoiceViewController.h"
#import "YLPictureViewController.h"
#import "YLWordViewController.h"


@interface YLEssenceViewController ()
<
    UIScrollViewDelegate
>

@property (nonatomic, strong) YLTitleButton *selectedBtn;
@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, weak)   UIView *titleView;
@property (nonatomic, strong) UIScrollView *scrollVoew;

@end

@implementation YLEssenceViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航栏
    [self setupNavigationItem];
    // 添加所有子控制器
    [self addAllChildViewController];
    //设置 scrollView
    [self setupScrollView];
    //设置 titleView
    [self setupTitleView];
    // 设置UnderLine
    [self setupUnderLine];
    // 默认选第一个
}
// 设置导航栏
- (void)setupNavigationItem{
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左面按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    // 右面按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
}
// 添加所有子控制器
- (void)addAllChildViewController{
    
    // 全部
    YLAllViewController *allVC = [[YLAllViewController alloc]init];
    [self addChildViewController:allVC];
    // 视频
    YLVideoViewController *videoVC = [[YLVideoViewController alloc]init];
    [self addChildViewController:videoVC];
    // 声音
    YLVoiceViewController *voiceVC = [[YLVoiceViewController alloc]init];
    [self addChildViewController:voiceVC];
    // 图片
    YLPictureViewController *pictureVC = [[YLPictureViewController alloc]init];
    [self addChildViewController:pictureVC];
    // 段子
    YLWordViewController *wordVC = [[YLWordViewController alloc]init];
    [self addChildViewController:wordVC];
    
}
// 添加一个子控制器
- (void)addOneChildViewIntoScrollVoew:(NSInteger)i{
    
    UIViewController *vc = self.childViewControllers[i];
    vc.view.frame = CGRectMake(i * self.scrollVoew.yl_width, 0, self.scrollVoew.yl_width, self.scrollVoew.yl_height);
    [self.scrollVoew addSubview:vc.view];
    
}
// 设置 scrollView
- (void)setupScrollView {
    
    UIScrollView *scrollVoew = [[UIScrollView alloc]init];
    scrollVoew.backgroundColor = YLColor(215, 215, 215);
    scrollVoew.frame = self.view.bounds;
    scrollVoew.showsHorizontalScrollIndicator = NO;
    scrollVoew.pagingEnabled = YES;
    scrollVoew.scrollsToTop = NO;
    scrollVoew.bounces = NO;
    scrollVoew.delegate = self;
    scrollVoew.contentSize = CGSizeMake(self.childViewControllers.count * self.view.yl_width, 0);
    [self.view addSubview:scrollVoew];
    self.scrollVoew = scrollVoew;
}
// 添加 titleView
- (void)setupTitleView {
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.frame = CGRectMake(0, YLNavBarMaxY, self.view.yl_width, YLTitleViewH);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    [self setupTitleButton];
}
// 添加 TitleButton
- (void)setupTitleButton{
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat btnW = self.view.yl_width / titles.count;
    CGFloat btnH = self.titleView.yl_height;
    for (NSInteger i = 0; i < titles.count; ++i) {
        
        YLTitleButton *btn = [YLTitleButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        if (i == 0) {
            [self titleBtnClick:btn];
        }
    }
}
// 设置活动指示器
- (void)setupUnderLine {
    
    YLTitleButton *firstBtn = self.titleView.subviews.firstObject;
    UIView *underLine = [[UIView alloc]init];
    CGFloat underLineH = 2;
    CGFloat underLineY = self.titleView.yl_height - underLineH;
    underLine.frame = CGRectMake(0, underLineY, 50, underLineH);
    underLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    self.underLine = underLine;
    [self.titleView addSubview:underLine];
    
    // 设置下划线的位置和大小
    [firstBtn.titleLabel sizeToFit];
    underLine.yl_width = firstBtn.titleLabel.yl_width;
    underLine.yl_centerX = firstBtn.yl_centerX;
}
#pragma mark - UIScrollViewDelegate
// 结束滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = self.scrollVoew.contentOffset.x / self.scrollVoew.yl_width;
    YLTitleButton *btn = self.titleView.subviews[index];
    [self titleBtnClickOtherDeal:btn];
}

#pragma mark - 点击事件
// 按钮点击事件
- (void)titleBtnClick:(YLTitleButton*)btn {
    
    if (self.selectedBtn == btn) {
        // 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:YLTitleButtonDidRepeatClickNotification object:nil];
        return;
    }
    // 更改按钮,下划线,ScrollsToTop状态
    [self titleBtnClickOtherDeal:btn];
}
- (void)titleBtnClickOtherDeal:(YLTitleButton*)btn{
    
    // 更改按钮状态
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    // 更改下划线宽度
    self.underLine.yl_width = btn.titleLabel.yl_width;
    [self.scrollVoew setContentOffset:CGPointMake(btn.tag * self.view.yl_width, 0) animated:YES];
    // 更改下划线位置
    [UIView animateWithDuration:0.25 animations:^{
        
        self.underLine.yl_centerX = btn.yl_centerX;
        
    } completion:^(BOOL finished) {
        //添加子控制器的 veiw
        [self addOneChildViewIntoScrollVoew:btn.tag];
        // 设置子控制器 View 的ScrollsToTop属性
        [self setChildViewScrollsToTop:btn.tag];
    }];
    //[self setChildViewScrollsToTop:btn.tag];
}
// 设置子控制器 View 的ScrollsToTop属性
- (void)setChildViewScrollsToTop:(NSInteger)index{
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *childVC = self.childViewControllers[i];
        if (!childVC.isViewLoaded) continue;
        
        UIView *childVCView = childVC.view;
        
        if ([childVCView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)childVCView;
            scrollView.scrollsToTop = (i == index);
           // NSLog(@"%zd--%zd--%zd",i,index,scrollView.scrollsToTop);
        }
    }
}
// 左面按钮点击
- (void)game{
    
    
}
// 右面按钮点击
- (void)random{
    
    
}






@end
