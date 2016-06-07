//
//  AboutViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "AboutViewController.h"


@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self addTitleViewWithName:@"关于我们"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
    
    [self uiconfig];
}
- (void)uiconfig{
    [self.view addSubview:[ZCControl createImageViewWithRect:CGRectMake(120, 100, 80, 80) imageName:@"aboutus_logo"]];
    UILabel * tLab =[ZCControl createLabelWithRect:CGRectMake(140, 180, 60, 30) text:@"头版"];
    tLab.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:tLab];
    UILabel * dLab= [ZCControl createLabelWithRect:CGRectMake(80, 200, 160, 30) text:@"关注最有价值的资讯"];
    dLab.font = [UIFont systemFontOfSize: 16];
    dLab.textAlignment = NSTextAlignmentCenter;
    dLab.textColor = [UIColor darkGrayColor];
    [self.view addSubview:dLab];
    [self.view addSubview:[ZCControl createImageViewWithRect:CGRectMake(72.5, 416-43, 165, 13) imageName:@"aboutus_4"]];
    
}
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
