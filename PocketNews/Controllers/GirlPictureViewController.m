//
//  GirlPictureViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "GirlPictureViewController.h"

@interface GirlPictureViewController ()

@end

@implementation GirlPictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTitleViewWithName:@"下载"];
    
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
	
    UIWebView * v = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL * url = [NSURL URLWithString:_articleUrl];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [v loadRequest:request];
    NSLog(@"url%@",url);
    [self.view addSubview:v];
    
}
- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
