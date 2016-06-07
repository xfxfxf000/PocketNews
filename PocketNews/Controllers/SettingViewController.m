//
//  SettingViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "SettingViewController.h"
#import "SwitchView.h"
#import "GuideViewController.h"
#import "AboutViewController.h"
#import "UMFeedback.h"
#import "AFHTTPRequestOperationManager.h"
#import "mianzeViewController.h"
@interface SettingViewController ()<UIAlertViewDelegate>
{
    UILabel * wordSizeLabel;
    NSMutableArray * _dataArray;
}
@end

@implementation SettingViewController

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
	_dataArray = [[NSMutableArray alloc]init];
    [self uiconfig];
}
- (void)uiconfig
{
    [self addTitleViewWithName:@"设置"];
    [self addItemWithTitle:nil imageName:@"channelManager_arrow" action:@selector(leftItemClick) location:YES];
    
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT)];
    scroll.contentSize = CGSizeMake(320, 800-200);
    scroll.userInteractionEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    [scroll addSubview:[ZCControl createImageViewWithRect:CGRectMake(0, 0, 320, 999) imageName:nil]];
    
    
    SwitchView * sView1 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 310-100, 320, 70)];
    sView1.target = self;
    sView1.action = @selector(downloadData);
    [[sView1.subviews objectAtIndex:1]removeFromSuperview];
    [sView1 setSwitchViewWithTitle:@"反馈"];
    [scroll addSubview:sView1];
    
//    SwitchView * sView2 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 80, 320, 70)];
//    sView2.target = self;
//    sView2.action = @selector(download:);
//    [[sView2.subviews objectAtIndex:1]removeFromSuperview];
//    [sView2 setSwitchViewWithTitle:@"离线下载"];
//    [scroll addSubview:sView2];
    
    SwitchView * sView3 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 210-100, 320, 70)];
    sView3.target = self;
    sView3.action = @selector(cleanCaches);
    [[sView3.subviews objectAtIndex:1]removeFromSuperview];
    [sView3 setSwitchViewWithTitle:@"清除缓存"];
    [scroll addSubview:sView3];
    
    SwitchView * sView4 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 10, 320, 70)];
    sView4.target = self;
    sView4.action = @selector(changeArticleWordSize);
    UISwitch * s = (UISwitch *)[sView4.subviews objectAtIndex:1];
    [s removeFromSuperview];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    CGFloat wordSize = [defaults floatForKey:@"size"];
    if (wordSize == 14) {
        wordSizeLabel = [ZCControl createLabelWithRect:CGRectMake(220, 20, 80, 30) text:@"小号字"];
    }
    else if(wordSize == 18){
        wordSizeLabel = [ZCControl createLabelWithRect:CGRectMake(220, 20, 80, 30) text:@"中号字"];
    }
    else if(wordSize == 22){
        wordSizeLabel = [ZCControl createLabelWithRect:CGRectMake(220, 20, 80, 30) text:@"大号字"];
    }
    else {
        wordSizeLabel = [ZCControl createLabelWithRect:CGRectMake(220, 20, 80, 30) text:@"特大号字"];
    }
    wordSizeLabel.textAlignment = NSTextAlignmentCenter;
    [sView4 addSubview:wordSizeLabel];
    [sView4 setSwitchViewWithTitle:@"正文字号"];
    [scroll addSubview:sView4];
    

    
//    SwitchView * sView8 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 110, 320, 70)];
//    sView8.target = self;
//    sView8.action = @selector(changeScanMode:);
//    [sView8 setSwitchViewWithTitle:@"夜间模式"];
//    [scroll addSubview:sView8];
    
    SwitchView * sView9 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 410-100, 320, 70)];
    sView9.target = self;
    sView9.action = @selector(downloadData1);
    [[sView9.subviews objectAtIndex:1]removeFromSuperview];
    [sView9 setSwitchViewWithTitle:@"检查更新"];
    [scroll addSubview:sView9];
    
    SwitchView * sView10 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 510-100, 320, 70)];
    sView10.target = self;
    sView10.action = @selector(guide:);
    [[sView10.subviews objectAtIndex:1]removeFromSuperview];
    [sView10 addSubview:[ZCControl createImageViewWithRect:CGRectMake(260, 20, 30, 30) imageName:@"jto"]];
    [sView10 setSwitchViewWithTitle:@"使用指南"];
    [scroll addSubview:sView10];
    
    
//    SwitchView * sView12 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 610-100, 320, 70)];
//    sView12.target = self;
//    sView12.action = @selector(about:);
//    [[sView12.subviews objectAtIndex:1]removeFromSuperview];
//    [sView12 addSubview:[ZCControl createImageViewWithRect:CGRectMake(260, 20, 30, 30) imageName:@"jto"]];
//    [sView12 setSwitchViewWithTitle:@"关于我们"];
//    [scroll addSubview:sView12];
    
    SwitchView * sView7 = [[SwitchView alloc]initWithFrame:CGRectMake(0, 710-100-100, 320, 70)];
    sView7.target = self;
    sView7.action = @selector(downloadData2:);
    [[sView7.subviews objectAtIndex:1]removeFromSuperview];
    [sView7 setSwitchViewWithTitle:@"免责声明"];
    [scroll addSubview:sView7];
    
    
}
-(void)downloadData2:(SwitchView *)sv{
    UIButton * btn = (UIButton *)[sv.subviews objectAtIndex:0];
    btn.selected =!btn.selected;
    
    mianzeViewController * guide = [[mianzeViewController alloc]init ];
    [self.navigationController pushViewController:guide animated:YES];
    
}
- (void)leftItemClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)downloadData1{
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}
- (void)switchBtn
{
    
}
- (void)downloadData
{
    //反馈
    
    [UMFeedback showFeedback:self withAppkey:kUMKeyString];
}
- (void )cleanCaches
{
    //清理缓存
   UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认清除？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alert show];

}
- (void)changeArticleWordSize
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 280, 200)];
    imageView.backgroundColor = [UIColor darkGrayColor];
    imageView.tag = 1234;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    UILabel * lab = [ZCControl createLabelWithRect:CGRectMake(0, 0, 280, 40) text:@"正文字体"];
    lab.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:lab];
    NSArray * array = [NSArray arrayWithObjects:@"小号字",@"中号字",@"大号字",@"特大号字",@"确定", nil];
    for (int i = 0; i < 5; i ++ ) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 40 + i * 30 , 240, 20);
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        NSLog(@"ssss%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"size"]);
        NSLog(@"ss%f",([[NSUserDefaults standardUserDefaults]floatForKey:@"size"]-14)/4);
        if (([[NSUserDefaults standardUserDefaults]floatForKey:@"size"]-14)/4 == i) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.selected = YES;
        }
        else{
            btn.selected = NO;
        }
        btn.tag = 123 + i;
        [btn addTarget:self action:@selector(changeWordSize:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
    }
    
}
- (void)changeWordSize:(UIButton *)btn
{
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag:1234];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    switch (btn.tag - 123) {
        case 0:
        {
            [defaults setFloat:14 forKey:@"size"];
            wordSizeLabel.text = @"小号字";
        }
            break;
        case 1:
        {
            [defaults setFloat:18 forKey:@"size"];
            wordSizeLabel.text = @"中号字";
        }
            break;
        case 2:
        {
            [defaults setFloat:22 forKey:@"size"];
            wordSizeLabel.text = @"大号字";
        }
            break;
        case 3:
        {
            [defaults setFloat:26 forKey:@"size"];
            wordSizeLabel.text = @"特大号字";
        }
            break;
        case 4:
        {
            [imageView removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
    for (UIView * view  in imageView.subviews) {
        if ([view isKindOfClass:[UIButton class]]){
            UIButton * button = (UIButton *)view;
            if (button.tag == btn.tag) {
                button.selected = YES;
            }
            else{
                button.selected = NO;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [defaults synchronize];
}
- (void)changeScanMode:(SwitchView *)sv
{
    UIButton * btn = (UIButton *)[sv.subviews objectAtIndex:0];
    UISwitch * s = (UISwitch *)[sv.subviews objectAtIndex:1];
    s.on = !btn.selected;
    btn.selected =!btn.selected;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * modeImage = [defaults objectForKey:@"modeImage"];
    if ([modeImage isEqualToString:@"nightmode"]) {
        [defaults setObject:@"daymode" forKey:@"modeImage"];
        [defaults setObject:@"日间模式" forKey:@"modeName"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"nightmode" object:nil];
    }
    else{
        [defaults setObject:@"nightmode" forKey:@"modeImage"];
        [defaults setObject:@"夜间模式" forKey:@"modeName"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"daymode" object:nil];
    }
    [defaults synchronize];
}
- (void)nightmodeClick
{
    UIScrollView * scroll = [self.view.subviews objectAtIndex:0];
    for (UIView * view in scroll.subviews) {
        if([view isKindOfClass:[UIImageView class]]){
            UIImageView * iv = (UIImageView *)view;
            iv.image = [UIImage imageNamed:@"leftViewBgImage"];
        }
        else if([view isKindOfClass:[UIView class]]){
            UIButton * btn = (UIButton *)[view.subviews objectAtIndex:0];
            [btn setImage:[UIImage imageNamed:@"leftViewBgImage"] forState:UIControlStateNormal];
            [[view.subviews objectAtIndex:0] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}
- (void)update:(SwitchView *)sv
{
    [self useAFNetworking];
}
- (void)useAFNetworking
{

}
- (void)guide:(SwitchView *)sv{
    UIButton * btn = (UIButton *)[sv.subviews objectAtIndex:0];
    btn.selected =!btn.selected;
    
    GuideViewController * guide = [[GuideViewController alloc]init ];
    guide.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:guide animated:YES completion:^{
        
    }];
    
}

- (void)about:(SwitchView *)sv{
    UIButton * btn = (UIButton *)[sv.subviews objectAtIndex:0];
    btn.selected =!btn.selected;
    
    AboutViewController * guide = [[AboutViewController alloc]init ];
    [self.navigationController pushViewController:guide animated:YES];
    
}
- (void)downloadData:(SwitchView *)sv
{
    UIButton * btn = (UIButton *)[sv.subviews objectAtIndex:0];
    UISwitch * s = (UISwitch *)[sv.subviews objectAtIndex:1];
    s.on = !btn.selected;
    btn.selected =!btn.selected;

}


@end
