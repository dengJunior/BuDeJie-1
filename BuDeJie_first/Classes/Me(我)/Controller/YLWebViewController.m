//
//  YLWebViewController.m
//  BuDeJie_first
//
//  Created by 张银龙 on 16/2/22.
//  Copyright © 2016年 张银龙. All rights reserved.
//

#import "YLWebViewController.h"
#import <WebKit/WebKit.h>

@interface YLWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwordBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic)  WKWebView *webView;
@end

@implementation YLWebViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]init];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [_conView addSubview:webView];
    _webView = webView;

    //KVO
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    WKWebView *webView = _conView.subviews[0];
    webView.frame = _conView.bounds;
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    _backBtn.enabled = _webView.canGoBack;
    _forwordBtn.enabled = _webView.canGoForward;
    _progressView.progress = _webView.estimatedProgress;
    _progressView.hidden = _webView.estimatedProgress >= 1.0;
    
}
- (void)dealloc{
    
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
#pragma mark - 按钮点击事件
- (IBAction)refresh:(id)sender {
    [_webView reload];
}
- (IBAction)goBack:(id)sender {
    [_webView goBack];
}
- (IBAction)goForword:(id)sender {
    [_webView goForward];
}




@end
