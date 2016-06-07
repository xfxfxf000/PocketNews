//
//  AccountViewController.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "ParentViewController.h"

@interface AccountViewController : ParentViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *autographLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sinaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tencentImageView;

@property (weak, nonatomic) IBOutlet UILabel *sinaLabel;
@property (weak, nonatomic) IBOutlet UILabel *tencentLabel;

- (IBAction)bindSina:(id)sender;
- (IBAction)bindTencent:(id)sender;




- (IBAction)quitLogin:(id)sender;

@property (nonatomic ,copy)NSString * iconUrl;
@property (nonatomic ,copy)NSString * name;
@property (nonatomic ,copy)NSString * autograph;

@end
