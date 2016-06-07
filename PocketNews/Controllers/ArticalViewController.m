//
//  ArticalViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "ArticalViewController.h"

#import "HttpRequest.h"
#import "UIImageView+WebCache.h"
#import "CommentViewController.h"
#import "EditViewController.h"
#import "DBManager.h"
#import "UMSocial.h"
#import <MessageUI/MessageUI.h>
#import "AFHTTPRequestOperationManager.h"

@interface ArticalViewController ()<UMSocialUIDelegate,UIAlertViewDelegate>
{
    UIImageView * bgImageView;
    UIImageView * sImageView;
    UIButton * favoriteBtn;
    UIButton * commentBtn;
    UIScrollView * scroll;
    
    
    NSString * shareArticleUrl;
    NSString * shareImgUrl;
    NSString * summary;
    NSString * title;
    BOOL  isFirst;
    
    NSString * netName;
    NSString * contentTitle;
    NSString * time;
    NSString * textImageName;
    NSString * contentUrl;
    NSString * contentAbstract;
    NSNumber * flowerNum;
    NSNumber * eggNum;
    NSNumber * reviewNum;
    
    NSMutableArray * commentArray;
    NSString * commentName;
    NSString * commentTitle;
    NSString * commentText;
    NSString * commentTime;
    
    BOOL isOpen;
    UILabel * modeLabel;
    UIButton * modeBtn;
    
    
//    UMSocialBar * socialBar;
    UMSocialAccountEntity * snsAccount;
}
@end

@implementation ArticalViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
    self.navigationItem.hidesBackButton = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    
    [self createNavigationBar];
    [self createToolBar];
    [self loadWaitingView];


    if (_articalUrl) {
        isFirst = NO;
        [HttpRequest requestWithUrlString:[NSString stringWithFormat:kArticleDetailString,_articalUrl ]target:self action:@selector(requestFinisted:)];
        NSLog(@"%@",[NSString stringWithFormat:kArticleDetailString,_articalUrl ]);
    }
    else
        [HttpRequest requestWithUrlString:[NSString stringWithFormat: kArticleString,_modal.articleId ]target:self action:@selector(requestFinisted:)];
    if (reviewNum.integerValue) {
        [commentBtn setImage:[UIImage imageNamed:@"reviewNum"] forState:UIControlStateNormal];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 20, 10)];
        label.text = [NSString stringWithFormat:@"%d",reviewNum.integerValue];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [commentBtn addSubview:label];
    }


}
- (void )initData
{
    shareArticleUrl = [[NSString alloc]init];
    shareImgUrl = [[NSString alloc]init ];
    summary = [[NSString alloc]init ];
    title = [[NSString alloc]init ];
    isFirst = YES;
    
    contentTitle = [[NSString alloc]init];
    netName = [[NSString alloc]init ];
    time = [[NSString alloc]init ];
    textImageName= [[NSString alloc]init ];
    contentUrl= [[NSString alloc]init ];
    contentAbstract= [[NSString alloc]init ];

   
    commentArray = [[NSMutableArray alloc]init ];
    commentName = [[NSString alloc]init ];
    commentTitle = [[NSString alloc]init ];
    commentText = [[NSString alloc]init ];
    commentTime = [[NSString alloc]init ];
    
    isOpen = NO;
    
}
- (void)createNavigationBar{
    
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
//    UIBarButtonItem * item2 = [self addItemWithTitle:nil imageName:@"no_commenTips" action:@selector(comment)];
//    UIBarButtonItem * item2 = [self addItemWithTitle:nil imageName:@"favorite" action:@selector(favorite)];
    //收藏
    favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(0, 0, 30, 30);
    [favoriteBtn setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    [favoriteBtn setImage:[UIImage imageNamed:@"redStar"] forState:UIControlStateSelected];
    [favoriteBtn addTarget:self action:@selector(favorite) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.selected = NO;
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:favoriteBtn];
    
    DBManager * manager = [DBManager shareManager];
    NSArray *favoriteDatas = [manager fetchAllData];
    for (TopModel *model in favoriteDatas) {
        if ([model.articleId isEqualToString:[NSString stringWithFormat:@"%@", _modal.articleId]]) {
            favoriteBtn.selected = YES;
        }
    }
    
//    //评论
    commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(0, 0, 30, 30);
    [commentBtn setImage:[UIImage imageNamed:@"no_commenTips"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.selected = NO;
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithCustomView:commentBtn];
    
    NSArray * itemArray = [NSArray arrayWithObjects:item1, item2, nil];
    self.navigationItem.rightBarButtonItems = itemArray;
   
}
//下方分享栏的实现
- (void)createToolBar
{
    
    ZCControl * nView = [[ZCControl alloc]init];
    [nView setToolBarRect:CGRectMake(0, HEIGHT-49, WIDTH, 49) backgroundImageName:@"homeNavBarBg" backgroundColor:nil];
    [nView addItemWithRect:CGRectMake( 80 , 9.5, 30, 30) image:@"shareBar_sinaWeibo_actived" target:self action:@selector(shareToSinaClick)];
    [nView addItemWithRect:CGRectMake( 150 , 9.5, 30, 30) image:@"shareBar_txWeibo_actived" target:self action:@selector(shareToTxClick)];
    [self.view addSubview:nView];
    [self.view addSubview:[nView.subviews objectAtIndex:0]];
}
- (void)loadWaitingView
{
    //预加载图片
    bgImageView = [ZCControl createImageViewWithRect:CGRectMake(0, 0, WIDTH, HEIGHT) imageName:nil];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView ];
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    
    //进行界面的动画
    for (int i = 0 ; i < 12; i ++ ) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i + 1]];
        [imageArray addObject:image];
    }
    UIImageView *  animationView= [ZCControl createImageViewWithRect:CGRectMake(142, 170, 36, 36) imageName:nil];
    animationView.layer.cornerRadius = 18;
    animationView.animationImages = imageArray;
    animationView.backgroundColor = [UIColor darkGrayColor];
    animationView.animationDuration = 2;
    [animationView startAnimating];
    [bgImageView addSubview:animationView];
}
#define kOriginX 20
#define kOriginY 30
#define kSizeWidth 320


- (void)createMainView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    scroll = [ZCControl createScrollViewWithRect:CGRectMake(0, 0, 320, HEIGHT-49)];
    scroll.contentSize = CGSizeMake(kSizeWidth, 1200 );
    [self.view addSubview:scroll];
    
    
    //标题
    UILabel * titleLabel = [ZCControl createLabelWithRect:CGRectMake(20, 74, 280, 60) text:contentTitle];
    titleLabel.numberOfLines = 2;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scroll addSubview:titleLabel];
    
    //来源，时间
    
    UILabel * infoLabel = [ZCControl createLabelWithRect: CGRectMake(20, 144, 280, 30) text:[NSString stringWithFormat:@"%@  %@",_modal.sourceName,time]];
    infoLabel.font = [UIFont systemFontOfSize:13];
    infoLabel.textColor = [UIColor darkGrayColor];
    [scroll addSubview:infoLabel];
    
    //图片
    int nextHeight = 120;
    if ([shareImgUrl isKindOfClass:[NSString class]]) {
        UIImageView * textImageView = [ZCControl createImageViewWithRect:CGRectMake(10, 184, 300, 280) imageName:nil];
        [textImageView setImageWithURL:[NSURL URLWithString:shareImgUrl] placeholderImage:[UIImage imageNamed:@"bglogo"]];
        [scroll addSubview:textImageView];
        nextHeight += 300;
    }
    
    //内容
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    CGFloat wordSize = [defaults floatForKey:@"size"];
    CGSize size = [contentAbstract sizeWithFont:[UIFont systemFontOfSize:wordSize] constrainedToSize:CGSizeMake(300, 99999) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel * textLabel = [ZCControl createLabelWithRect:CGRectMake(10, nextHeight+64, size.width, size.height) text:contentAbstract];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:wordSize];
    [scroll addSubview:textLabel];
    
    //赞，踩
    CGFloat newHeight = nextHeight + size.height;
    
    UIButton * praiseBtn = [ZCControl createButtonWithRect:CGRectMake(70, newHeight + 84, 80, 40) title:nil normalImage:@"big_praise" selectedIamge:@"dArticlecomment_praise" target:self action:@selector(praiseBtnClick:)];
    praiseBtn.tag = 12;
    [scroll addSubview:praiseBtn];
    
    UIButton * badBtn = [ZCControl createButtonWithRect:CGRectMake(170, newHeight + 84, 80, 40) title:nil normalImage:@"big_bad" selectedIamge:@"dArticlecomment_bad" target:self action:@selector(praiseBtnClick:)];
    badBtn.tag = 21;
    [scroll addSubview:badBtn];
    
    UILabel * flowerLabel = [ZCControl createLabelWithRect:CGRectMake(40, 0, 40, 40) text:[NSString stringWithFormat:@"%d",flowerNum.integerValue]];
    UILabel * eggLabel = [ZCControl createLabelWithRect:CGRectMake(40, 0, 40, 40) text:[NSString stringWithFormat:@"%d",eggNum.integerValue]];
    flowerLabel.tag = 13;
    eggLabel.tag = 14;
    [praiseBtn addSubview:flowerLabel];
    [badBtn addSubview:eggLabel];
    
    //评论
    UIImageView * commentView = [ZCControl createImageViewWithRect:CGRectMake(0, newHeight + 144, 320, 14) imageName:@"articlecomment_header"];
    [scroll addSubview:commentView];
    
    int count = [commentArray count];
    NSLog(@"comment:%d",count);
    int  h = newHeight+104;
    if (count >= 3) {
        for (int i = 0 ; i < 3; i ++) {
            NSDictionary * dict = [commentArray objectAtIndex:i];
            ZCControl * commentView = [[ZCControl alloc]initWithFrame:CGRectMake(0, newHeight + 104+64 + i * 70, 320, 70)];
            [commentView createCommentViewWithCommentCounts:0 imageName:nil title:[dict objectForKey:@"userNickName"] comment:[dict objectForKey:@"reviewContent"] time:[dict objectForKey:@"createTime"]];
            if (i < 2) {
                [commentView addSubview:[ZCControl createImageViewWithRect:CGRectMake(0, 68, 320, 2) imageName:@"tablecellsperate"]];
            }
            [scroll addSubview:commentView];
            h += 70;
        }
        UIButton * moreCommentBtn = [ZCControl createButtonWithRect:CGRectMake(20, h + 84, 280, 40) title:nil normalImage:@"more_comment" selectedIamge:nil target:self action:@selector(moreCommentClick)];
        [scroll addSubview:moreCommentBtn];
    }
    else if (count == 0) {
        UIButton * noCommentBtn = [ZCControl createButtonWithRect:CGRectMake(20, h + 84, 280, 40) title:nil normalImage:@"noComment" selectedIamge:nil target:self action:@selector(noCommentClick)];
        [scroll addSubview:noCommentBtn];
    }
    else{
        for (int i = 0 ; i < count; i ++) {
            NSDictionary * dict = [commentArray objectAtIndex:i];
            ZCControl * commentView = [[ZCControl alloc]initWithFrame:CGRectMake(0, newHeight + 104+64 + i * 70, 320, 70)];
            [commentView createCommentViewWithCommentCounts:0 imageName:nil title:[dict objectForKey:@"userNickName"] comment:[dict objectForKey:@"reviewContent"] time:[dict objectForKey:@"createTime"]];
            if (i < count -1) {
                [commentView addSubview:[ZCControl createImageViewWithRect:CGRectMake(0, 68, 320, 2) imageName:@"tablecellsperate"]];
            }
            [scroll addSubview:commentView];
            h += 70;
            UIButton * moreCommentBtn = [ZCControl createButtonWithRect:CGRectMake(20, h + 20+64, 280, 40) title:nil normalImage:@"more_comment" selectedIamge:nil target:self action:@selector(moreCommentClick)];
            [scroll addSubview:moreCommentBtn];
        }
    }
    
    UIImageView * shareImageView = [ZCControl createImageViewWithRect:CGRectMake(90, h+100+64 , 140, 50) imageName:@"share_happpy"];
    [scroll addSubview:shareImageView];
    
    
    scroll.contentSize = CGSizeMake(kSizeWidth, h + 160+64);

}

- (void)requestFinisted:(HttpRequest *)request{
    if (isFirst) {
        if (request.downloadData) {
            id result = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"result:%@",result);
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary * dict = (NSDictionary *)result;
                title = [dict objectForKey:@"title"];
                summary = [dict objectForKey:@"summary"];
                shareArticleUrl = [dict objectForKey:@"shareArticleUrl"];
                shareImgUrl = [dict objectForKey:@"shareImgUrl"];
                [self requestAgain];
            }
        }

    }
    else{
        isFirst = YES;
        NSString * s = [[NSString alloc]initWithData:request.downloadData encoding:NSUTF8StringEncoding ];

//        NSLog(@"SSSSSS:%@",s);
        NSString * dataString = [[s componentsSeparatedByString:@"jsonp_callback2("]objectAtIndex:1];
        NSString * ss =[dataString substringToIndex:dataString.length -3];
//        NSLog(@"data:%@",ss);
        NSData * data = [ss dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"result:%@",result);
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary * mdict = (NSDictionary *)result;
                NSDictionary * dict = [mdict objectForKey:@"summary"];
                contentTitle = [dict objectForKey:@"contentTitle"];
                if (!_modal) {
                    shareImgUrl = [dict objectForKey:@"contentPic"];
                    _sourceName = [dict objectForKey:@"operationName"];
                }
                time = [dict objectForKey:@"contentTime"];
                contentUrl = [dict objectForKey:@"contentUrl"];
                contentAbstract = [dict objectForKey:@"contentAbstract"];
                flowerNum = [dict objectForKey:@"flowerNum"];
                eggNum = [dict objectForKey:@"eggNum"];
                reviewNum = [dict objectForKey:@"reviewNum"];
                
                commentArray = [mdict objectForKey:@"list"];
                
                //有数据，则移除图片
                [bgImageView removeFromSuperview];
                
            }
            [self createMainView];
        }
        else{
            [[bgImageView.subviews objectAtIndex:0] removeFromSuperview];
            [bgImageView addSubview:[ZCControl createButtonWithRect:CGRectMake(110, 134, 100, 100) title:nil normalImage:@"noDataOriginal" selectedIamge:@"noDataTouch" target:self action:@selector(downloadData:)]];
        }
    }
}
- (void)requestAgain
{
    isFirst = NO;
    [HttpRequest requestWithUrlString:[NSString stringWithFormat:kArticleDetailString,shareArticleUrl] target:self action:@selector(requestFinisted:)];
    NSLog(@"kArticleDetailString-url:%@",[NSString stringWithFormat:kArticleDetailString,shareArticleUrl]);
}

- (void)downloadData:(UIButton *)btn
{
    NSLog(@"重新加载");
    [HttpRequest requestWithUrlString:[NSString stringWithFormat: kArticleString,_articleId ]target:self action:@selector(requestFinisted:)];
}

#pragma mark - NavigationBarItemMethod
- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//判定登陆收藏的
- (void)favorite
{
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent] || [UMSocialAccountManager isOauthWithPlatform:UMShareToSina]) {
        //已登陆
        DBManager * manager = [DBManager shareManager];
        if (favoriteBtn.selected == NO) {
            favoriteBtn.selected = YES;
            TopModel * modal = [[TopModel alloc]init ];
            modal.title = _modal.title;
            modal.firstPicUrl = _modal.firstPicUrl;
            modal.sourceName = _modal.sourceName;
            modal.reviewNum = _modal.reviewNum;
            modal.isHot = _modal.isHot;
            modal.articleId = _modal.articleId;

            [manager insertDataWithModal:modal];
            NSLog(@"收藏成功");
        }
        else{
            favoriteBtn.selected = NO;
            
            [manager deleteDataWithArticleId:_modal.articleId];
            NSLog(@"取消收藏");

        }
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"登录后才可以收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}
- (void)comment
{
    if (commentBtn.selected == NO) {
        CommentViewController * cvc = [[CommentViewController alloc]init ];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:cvc ];
        cvc.contentUrl = contentUrl;
        [self.navigationController presentViewController:nvc animated:YES completion:^{
            
        }];
    }
}
#pragma mark - MainArticleMethod
- (void)praiseBtnClick:(UIButton *)btn
{
    UIButton * button1 = (UIButton *)[scroll viewWithTag:12  ];
    UIButton * button2 = (UIButton *)[scroll viewWithTag:21  ];
    if (btn.tag == 12) {
        btn.selected = YES;
        button1.userInteractionEnabled = NO;
        button2.userInteractionEnabled = NO;
        UILabel * lab = (UILabel *)[btn viewWithTag:13];
        lab.text = [NSString stringWithFormat:@"%d",flowerNum.integerValue +1];
        lab.textColor = [UIColor colorWithRed:195.0/255 green:36.0/255 blue:39.0/255 alpha:1];
    }
    else {
        btn.selected = YES;
        button1.userInteractionEnabled = NO;
        button2.userInteractionEnabled = NO;
        UILabel * lab = (UILabel *)[btn viewWithTag:14];
        lab.text = [NSString stringWithFormat:@"%d",eggNum.integerValue +1];
        lab.textColor = [UIColor colorWithRed:195.0/255 green:36.0/255 blue:39.0/255 alpha:1];
    }
    
}
- (void)moreCommentClick
{
    
    CommentViewController * cvc = [[CommentViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:cvc];
    cvc.contentUrl = contentUrl;
    [self.navigationController presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (void)noCommentClick
{
    EditViewController * evc = [[EditViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:evc];
    [self.navigationController presentViewController:nvc animated:YES completion:^{
        
    }];
}
#pragma mark - ToolBarItemMethods

- (void)shareToSinaClick
{
    NSString * shareText = [NSString stringWithFormat:@"%@ %@",contentTitle,shareArticleUrl];
    //是否授权登陆腾讯微博
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToSina]) {
        //已授权登陆，则直接分享
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:nil socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else{
        //没有，则弹出登陆界面
        [[UMSocialControllerService defaultControllerService]setSocialUIDelegate:self];
        UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
            NSLog(@"login response:%@",response);
            if (response.responseCode == UMSResponseCodeSuccess) {
                snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
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
- (void)shareToTxClick
{
    NSString * shareText = [NSString stringWithFormat:@"%@ %@",contentTitle,shareArticleUrl];
    //是否授权登陆腾讯微博
    if ([UMSocialAccountManager isOauthWithPlatform:UMShareToTencent]) {
        //已授权登陆，则直接分享
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:nil socialUIDelegate:self];
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
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"respondesCode:%d",response.responseCode);
    NSLog(@"respondesData:%@",response.data);
}

-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService {
    return YES;
}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType {
    
}


@end
