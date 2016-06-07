//
//  RightViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "RightViewController.h"
#import "UMSocial.h"
#import "UIButton+WebCache.h"
#import "AccountViewController.h"


//=====================新浪 腾讯第三方登录界面
@interface RightViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>
{
    UMSocialAccountEntity * snsAccount;
    UIButton * iconBtn;
    UILabel * infoLab;
}
@end

@implementation RightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftViewBgImage@2x.png"]];
    self.view.backgroundColor = [UIColor blackColor];
    [self uiconfig];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quitLogin) name:@"quitLogin" object:nil];
}
- (void)uiconfig{
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-20)];
    bgImageView.image = [UIImage imageNamed:@"leftViewBgImage.png"];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
 
   //？？？？？？？？？？？？
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   //头像的
    iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.frame = CGRectMake(160, 160, 60, 60);
    iconBtn.layer.cornerRadius = 30;
    iconBtn.clipsToBounds = YES;
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent]) {
        [iconBtn setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"iconUrl"]]];
        iconBtn.userInteractionEnabled = YES;
    }
    else{
        [iconBtn setImage:[UIImage imageNamed:[defaults objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
        iconBtn.userInteractionEnabled = NO;
    }
    [iconBtn addTarget:self action:@selector(accountManager) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:iconBtn];
    
    infoLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 220, 220, 30)];
    infoLab.text = [defaults objectForKey:@"profileURL"];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = [UIFont systemFontOfSize:12];
    infoLab.textColor = [UIColor lightTextColor];
    [bgImageView addSubview:infoLab];

    
    UIButton * sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaBtn.frame = CGRectMake(80, 260, 220, 40);
    [sinaBtn setImage:[UIImage imageNamed:@"downSina"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:sinaBtn];
    UIButton * qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake(80, 310, 220, 40);
    [qqBtn setImage:[UIImage imageNamed:@"downQQ"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(tencentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:qqBtn];
}
- (void)tencentBtnClick
{
    [[UMSocialControllerService defaultControllerService]setSocialUIDelegate:self];
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
        NSLog(@"login response:%@",response);
        if (response.responseCode == UMSResponseCodeSuccess) {
            snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToTencent];
            NSLog(@"username:%@,iconUrl:%@,uid:%@,token:%@",snsAccount.userName,snsAccount.iconURL,snsAccount.usid,snsAccount.accessToken);
            
            NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:snsAccount.iconURL forKey:@"iconUrl"];
            [defaults setObject:snsAccount.userName forKey:@"userName"];
            [defaults setObject:snsAccount.profileURL forKey:@"profileURL"];
            [defaults synchronize];//同步
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
        }
    });
}
- (void)accountManager
{
    AccountViewController * avc = [[AccountViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:avc];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    avc.iconUrl = [defaults objectForKey:@"iconUrl"];
    avc.name = [defaults objectForKey:@"userName"];
    avc.autograph = [defaults objectForKey:@"profileURL"];
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (void)sinaBtnClick
{
    [[UMSocialControllerService defaultControllerService]setSocialUIDelegate:self];
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
        NSLog(@"login response:%@",response);
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity * account = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username:%@,iconUrl:%@,uid:%@,token:%@",account.userName,account.iconURL,account.usid,account.accessToken);
            NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:account.iconURL forKey:@"iconUrl"];
            [defaults setObject:account.userName forKey:@"userName"];
            [defaults setObject:account.profileURL forKey:@"profileURL"];
            [defaults synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
        }
    });
}
- (void)loginSuccess
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [iconBtn setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"iconUrl"]]];
    iconBtn.userInteractionEnabled = YES;
    infoLab.text = [defaults objectForKey:@"profileURL"];
    
}
- (void)quitLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [iconBtn setImage:[UIImage imageNamed:[defaults objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
    iconBtn.userInteractionEnabled = NO;
    infoLab.text = [defaults objectForKey:@"profileURL"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
