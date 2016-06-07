//
//  AccountViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "AccountViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "FavouriteViewController.h"

@interface AccountViewController ()<UIActionSheetDelegate>

@end

@implementation AccountViewController

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
    
    [self addTitleViewWithName:@"账号管理"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
    [self addItemWithTitle:nil imageName:@"ic_menu_home" action:@selector(rightItemClick) location:NO];
    
    [self showAccountInfo];
}
- (void)showAccountInfo
{
    [_iconImageView setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:[UIImage imageNamed:@"login_tip.png"]];
    _iconImageView.layer.cornerRadius = 20;
    _iconImageView.clipsToBounds = YES;
    _nameLabel.text = _name;
    _autographLabel.text = _autograph;
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent]) {
        [_tencentImageView setImage:[UIImage imageNamed:@"tencent_weibo_active@2X"]];
        _tencentLabel.text = @"解绑";
        _tencentLabel.textColor = [UIColor blackColor];
    }
    else{
        [_sinaImageView setImage:[UIImage imageNamed:@"shareBar_sinaWeibo_actived"]];
        _sinaLabel.text = @"解绑";
        _sinaLabel.textColor = [UIColor blackColor];
    }
}
- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)rightItemClick
{
    FavouriteViewController * fvc = [[FavouriteViewController alloc]init];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:fvc];
    [self.navigationController presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (IBAction)bindSina:(id)sender
{
    
}
- (IBAction)bindTencent:(id)sender
{
    if ([_tencentLabel.text isEqualToString:@"解绑"]) {
        UIActionSheet * unBindActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"解除授权", nil ];
        unBindActionSheet.destructiveButtonIndex = 0;
        self.navigationController.toolbarHidden = NO;
        [unBindActionSheet showInView:self.navigationController.toolbar];
    }
    else{
        UIActionSheet * unBindActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"解除授权", nil ];
        unBindActionSheet.destructiveButtonIndex = 0;
        self.navigationController.toolbarHidden = NO;
        [unBindActionSheet showInView:self.navigationController.toolbar];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UMSocialDataService defaultDataService]requestUnBindToSnsWithCompletion:^(UMSocialResponseEntity *response) {
            NSLog(@"unOauth response is %@",response);
            self.navigationController.toolbarHidden = YES;
            [_tencentImageView setImage:[UIImage imageNamed:@"shareBar_txWeibo_unactived"]];
            _tencentLabel.text = @"绑定";
            _tencentLabel.textColor = [UIColor redColor];
        }];
    }
    else
        self.navigationController.toolbarHidden = YES;
}
- (IBAction)bindZone:(id)sender
{
    
}
- (IBAction)quitLogin:(id)sender {
    [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToTencent completion:^(UMSocialResponseEntity *response) {
        NSLog(@"unOauth response:%@",response);
        [_iconImageView setImage:[UIImage imageNamed:@"login_tip.png"]];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.clipsToBounds = YES;
        _nameLabel.text = nil;
        _autographLabel.text = nil;
        
        NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"login_tip" forKey:@"iconUrl"];
        [defaults setObject:@"" forKey:@"userName"];
        [defaults setObject:@"登陆后，头条分享与微博互动更便捷！" forKey:@"profileURL"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"quitLogin" object:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
