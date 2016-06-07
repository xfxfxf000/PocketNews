//
//  mianzeViewController.m
//  头版的
//
//  Created by qianfeng on 15-2-4.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "mianzeViewController.h"

@interface mianzeViewController ()

@end

@implementation mianzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"免责声明"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
    
    [self uiconfig];
}
- (void)uiconfig{
    UILabel *label= [ZCControl createLabelWithRect:CGRectMake(20, 64, 300, 70) text:@"  1、PocketNews登载的所有新闻报道及文章均已经过相关媒体机构的合法授权，除PocketNews注明的法律条款外，其他因使用PocketNews导致的任何意外、过失、违约、诽谤、人身财产权、版权、知识产权的侵害，以及上述事件造成的损失（包括因浏览、使用、下载导致的计算机损坏）PocketNews均声明免责。"];
    label.numberOfLines=0;
    //让label动态变化frame，自适配
    [label sizeToFit];
    //设置文字颜色
    label.font = [UIFont systemFontOfSize: 16];
    
    label.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label];
    UILabel *label1= [ZCControl createLabelWithRect:CGRectMake(20, 224, 300, 70) text:@"  2、任何透过PocketNews网页而链接及得到的信息、产品及服务，以及因上述信息、产品及服务造成的任何损害，PocketNews概不负责，亦不负任何法律责任。"];
    label1.numberOfLines=0;
    //让label动态变化frame，自适配
    [label1 sizeToFit];
    //设置文字颜色
    label1.font = [UIFont systemFontOfSize: 16];
    
    label1.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label1];

    UILabel *label2= [ZCControl createLabelWithRect:CGRectMake(20, 310, 300, 70) text:@"  3、PocketNews内登载的所有内容均不能体现PocketNews的任何意见和观点。"];
    label2.numberOfLines=0;
    //让label动态变化frame，自适配
    [label2 sizeToFit];
    //设置文字颜色
    label2.font = [UIFont systemFontOfSize: 16];
    
    label2.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label2];

    UILabel *label3= [ZCControl createLabelWithRect:CGRectMake(20, 360, 300, 70) text:@"  4、不论您是否仔细阅读上述条款，只要您登陆了PocketNews及直接或间接浏览了发布在PocketNews的网页，均视为您已经阅读并能够完全同意。"];
    label3.numberOfLines=0;
    //让label动态变化frame，自适配
    [label3 sizeToFit];
    //设置文字颜色
    label3.font = [UIFont systemFontOfSize: 16];
    
    label3.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label3];
    
    UILabel *label4= [ZCControl createLabelWithRect:CGRectMake(20, 460, 300, 70) text:@" PocketNews    徐峰版权所有"];
    label4.numberOfLines=0;
    //让label动态变化frame，自适配
    [label4 sizeToFit];
    //设置文字颜色
    label4.font = [UIFont systemFontOfSize: 16];
    
    label4.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label4];
}
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
