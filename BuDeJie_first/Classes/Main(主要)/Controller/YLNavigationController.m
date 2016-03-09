//
//  YLNavigationController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/19.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLNavigationController.h"

@interface YLNavigationController ()<UIGestureRecognizerDelegate>



@end

@implementation YLNavigationController

+ (void)load{
    
    UINavigationBar *item = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [item setTitleTextAttributes:attr];
    
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {//非根控制器
    
        viewController.navigationItem.leftBarButtonItem =
        [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonReturn"]
                             highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]
                                target:self
                                action:@selector(back)
                                  name:@"返回"];
    
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //写在最后
    [super pushViewController:viewController animated:animated];
}

/**
    <UIScreenEdgePanGestureRecognizer: 0x7fc188570210;
    state = Possible;
    delaysTouchesBegan = YES;
    view = <UILayoutContainerView 0x7fc188562150>;
    target= <(action=handleNavigationTransition:,
    target=<_UINavigationInteractiveTransition 0x7fc18856fc20>)
 
    delegate =  <_UINavigationInteractiveTransition: 0x7f8ea8ecc800>
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //全屏左划返回
    /*
    id target = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    */
    //边缘左划返回
    //self.interactivePopGestureRecognizer.delegate = self;
    
    //NSLog(@"%@",self.interactivePopGestureRecognizer);
}
- (void)back{
    
    [self popViewControllerAnimated:YES];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    
//    return self.childViewControllers.count > 1;
//}

@end
