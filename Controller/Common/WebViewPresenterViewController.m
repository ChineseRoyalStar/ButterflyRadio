//
//  WebViewPresenterViewController.m
//  ButterflyRadio
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 com.ios.ijinan. All rights reserved.
//

#import "WebViewPresenterViewController.h"

#import <WebKit/WebKit.h>

@interface WebViewPresenterViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong) WKWebView *webView;

@end

@implementation WebViewPresenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadRequest];
}


- (WKWebView *)webView {
    
    if(!_webView){
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGTH-64) configuration:config];
        
        _webView.navigationDelegate = self;
        
        _webView.UIDelegate = self;
        
        _webView.allowsBackForwardNavigationGestures = YES;
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)loadRequest {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
