//
//  PicScanViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "PicScanViewController.h"
#import "HttpRequest.h"
#import "UIImageView+WebCache.h"

#import "EditViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UMSocial.h"

@interface PicScanViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>
{
    UIScrollView * _scroll;
    UIPageControl * _page;
    NSMutableArray * _dataArray;
    UILabel * lab;
    UMSocialAccountEntity * snsAccount;
    NSInteger currentPage;
}
@end

@implementation PicScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"1Default"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeNavBarBg"] forBarMetrics:UIBarMetricsDefault] ;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPage = 0;
    
    [self addItemWithTitle:nil imageName:@"goback" action:@selector(leftItemClick) location:YES];
    //[self addItemWithTitle:nil imageName:@"top_comment_btn@2x" action:@selector(rightItemClick) location:NO];
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT)];
    bgImageView.image = [UIImage imageNamed:@"1Default"];
    [self.view addSubview:bgImageView];
    
	_dataArray = [[NSMutableArray alloc]init ];

    [self requestTopWithAFNetworking];

}
- (void)uiScrollView
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, HEIGHT-49)];
    _scroll.contentSize = CGSizeMake(320 * _dataArray.count, HEIGHT - 64- 49);
    _scroll.tag = 111;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    for (int i = 0 ; i < _dataArray.count; i ++ ) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, HEIGHT-64-49)];
        [imageView setImageWithURL:[NSURL URLWithString:[_dataArray objectAtIndex:i ]]];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scroll addSubview:imageView];
    }

}
- (void)uiToolBar
{
    UIImageView * imageView = [ZCControl createImageViewWithRect:CGRectMake(0, HEIGHT-49, WIDTH, 49) imageName:@"leftViewBgImage"];
        UIButton * btn2 = [ZCControl createButtonWithRect:CGRectMake(WIDTH- 49, 0, 49, 49) title:nil normalImage:@"ShareButtonHighLightedIcon" selectedIamge:nil target:self action:@selector(shareImage)];
    [imageView addSubview:btn2];

    lab = [ZCControl createLabelWithRect:CGRectMake(100, 0, 120, 49) text:[NSString stringWithFormat:@"%d/%d",currentPage +1 ,_dataArray.count  ]];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [imageView addSubview:lab];
    
    [self.view addSubview:imageView];
    
}

- (void)requestTopWithAFNetworking
{
    AFHTTPRequestOperationManager * manager =[ AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:[NSString stringWithFormat:kPictureDetail,_articleId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] ) {
            NSLog(@"%@",responseObject);
            NSDictionary * dict = (NSDictionary *)responseObject;
            NSArray * array = [dict objectForKey:@"pictureList"];
            for (NSDictionary * m in array) {
                NSString * pictureUrl = [m objectForKey:@"pictureUrl"];
                [_dataArray addObject:pictureUrl];
            }
        }
        [self uiScrollView];
        [self uiToolBar];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response:%@",error.localizedDescription);
    }];
}
- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)shareImage
{
    NSString * string = [_dataArray objectAtIndex:currentPage];
    UIImage  * shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
    //是否授权登陆腾讯微博
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent]) {
        //已授权登陆，则直接分享
        [[UMSocialControllerService defaultControllerService] setShareText:nil shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else{
        //没有，则弹出登陆界面
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
                [defaults synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
            }
        });
        
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentPage = _scroll.contentOffset.x/320;
    NSLog(@"sssss:%@",_scroll.subviews);
    NSLog(@"%f",_scroll.contentOffset.x);
    lab.text = [NSString stringWithFormat:@"%d/%d",currentPage + 1,_dataArray.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
