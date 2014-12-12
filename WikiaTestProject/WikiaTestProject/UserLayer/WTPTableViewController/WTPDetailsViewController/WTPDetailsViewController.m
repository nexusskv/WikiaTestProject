//
//  WTPDetailsViewController.m
//  WikiaTestProject
//
//  Created by rost on 10.12.14.
//  Copyright (c) 2014 Rost. All rights reserved.
//

#import "WTPDetailsViewController.h"


@interface WTPDetailsViewController () <UIWebViewDelegate>

@end


@implementation WTPDetailsViewController

#pragma mark - View life cycle
- (void)loadView {
    [super loadView];
    
    self.title = self.titleString;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.delegate            = self;
    webView.dataDetectorTypes   = UIDataDetectorTypeAll;
    webView.backgroundColor     = [UIColor clearColor];
    webView.opaque              = NO;
    webView.scalesPageToFit     = YES;
    webView.contentMode         = UIViewContentModeScaleAspectFit;

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:webView];
    
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"webView"  : webView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
}
#pragma mark - 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
