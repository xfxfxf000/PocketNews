//
//  LeftViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftCell.h"
#import "ColumnModel.h"
#import "SettingViewController.h"
#import "RootViewController.h"
#import "SubscribeViewController.h"
#import "DrawerViewController.h"
#import "RightViewController.h"

#import "TopViewController.h"
#import "EntertainmentViewController.h"
#import "FinanceViewController.h"
#import "ScienceViewController.h"
#import "PictureViewController.h"
#import "ValueTransfer.h"
#import "SubscribeModal.h"
#import "UIImageView+WebCache.h"
#import "NewsViewController.h"
#import "GirlsViewController.h"
#import "TMDViewController.h"
#import "TiyuViewController.h"
#import "tousuViewController.h"
#import "gaoxiaoViewController.h"
#import "QicheViewController.h"
#import "TansuoViewController.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    BOOL isFirst;
}
@end

@implementation LeftViewController

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

//    [self.view addSubview: [ZCControl createImageViewWithRect:CGRectMake(0, 20, 150, 44) imageName:@"NavBgImage"]];
    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 20, 44, 44);
//    [btn setImage:[UIImage imageNamed:@"settingButton"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(settingItemClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    if (isFirst == NO) {
//        _dataArray = [NSMutableArray arrayWithArray: [ValueTransfer shareValue].valueArray];
//        [_tableView reloadData];
//    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initData];
    [self uiconfig];
}
- (void)initData{
    
    isFirst  = YES;
    if (isFirst) {
        _dataArray = [[NSMutableArray alloc]init ];
        NSArray * imageArray=[[NSArray alloc]initWithObjects:@"投诉",@"娱乐",@"科技",@"财经",@"读图",@"email",@"writereview",@"搞笑",@"汽车",@"探索", nil];
        NSArray * nameArray=[[NSArray alloc]initWithObjects:@"投诉",@"娱乐",@"科技",@"财经",@"读图",@"星座",@"体育",@"搞笑",@"汽车",@"探索",nil];
        for (int i = 0 ; i < imageArray.count; i ++ ) {
            SubscribeModal * model = [[SubscribeModal alloc]init ];
            model.thumbImgUrl = [imageArray objectAtIndex:i];
            model.title = [nameArray objectAtIndex:i];
            [_dataArray addObject:model];
        }
        //        isFirst = NO;
    }
    else{
    _dataArray = [NSMutableArray arrayWithArray: [ValueTransfer shareValue].valueArray];
    }
}
- (void)settingItemClick
{
    SettingViewController * svc = [[SettingViewController alloc]init ];

    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:svc];
    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:nvc animated:YES completion:^{
    }];
}
- (void)uiconfig
{


    self.navigationController.navigationBarHidden = YES;
//    [self.view addSubview: [ZCControl createImageViewWithRect:CGRectMake(0, 20, 150, 44) imageName:@"NavBgImage"]];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 150, 44)];
    lab.text = @"PocketNews";
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textColor = [UIColor whiteColor];
    [self.view addSubview:lab];

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(106, 20, 44, 44);
    [btn setImage:[UIImage imageNamed:@"settingButton"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(settingItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 150, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];

}
#pragma mark - TableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count + 1;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFirst) {
        static NSString * cellId = @"Cell";
        LeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil ) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row == 0) {
            cell.columnImageView.image = [UIImage imageNamed:@"头条.png"];
            cell.titleLabel.text = @"头条";
        }
        
        else{
            SubscribeModal * model = [_dataArray objectAtIndex:indexPath.row - 1];
            cell.columnImageView.image = [UIImage imageNamed:model.thumbImgUrl];
            cell.titleLabel.text = model.title;
        }
        return cell;

    }
    else{
        static NSString * cellId = @"Cell";
        LeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil ) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row == 0) {
            cell.columnImageView.image = [UIImage imageNamed:@"头条.png"];
            cell.titleLabel.text = @"头条";
        }
        else if (indexPath.row == _dataArray.count + 1) {
            cell.columnImageView.image = [UIImage imageNamed:@"读图.png"];
            cell.titleLabel.text = @"美女";
        }
        else if (indexPath.row == _dataArray.count + 2) {
            cell.columnImageView.image = [UIImage imageNamed:@"科技.png"];
            cell.titleLabel.text = @"科技";
        }


        else if (indexPath.row == _dataArray.count + 3) {
            cell.columnImageView.image = [UIImage imageNamed:@"orderMore"];
            cell.titleLabel.text = @"订阅更多";
        }
        else{
            SubscribeModal * model = [_dataArray objectAtIndex:indexPath.row - 1];
            [cell.columnImageView setImageWithURL: [NSURL URLWithString:model.thumbImgUrl]];
            cell.titleLabel.text = model.title;
        }
        return cell;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if(indexPath.row == 0){
        RightViewController * right = [[RightViewController alloc]init ];
        UIWindow * window =  [[UIApplication sharedApplication]keyWindow];
        TopViewController * tvc = [[TopViewController alloc]init ];
            tvc.noShowAppStart = YES;
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:tvc ];
        DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
        window.rootViewController = DrawerVC;
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:nvc animated:YES completion:^{
        }];
    }
    else if(indexPath.row == _dataArray.count + 1){
        RightViewController * right = [[RightViewController alloc]init ];
        UIWindow * window =  [[UIApplication sharedApplication]keyWindow];
        GirlsViewController * tvc = [[GirlsViewController alloc]init ];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:tvc ];
        DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
        window.rootViewController = DrawerVC;
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:nvc animated:YES completion:^{
        }];
    }
        else {
            RightViewController * right = [[RightViewController alloc]init ];
            UIWindow * window =  [[UIApplication sharedApplication]keyWindow];
            if(indexPath.row == 1){
                tousuViewController * evc = [[tousuViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:evc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            if(indexPath.row == 2){
                EntertainmentViewController * evc = [[EntertainmentViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:evc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 3){
                ScienceViewController * svc = [[ScienceViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:svc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 4){
                FinanceViewController * fvc = [[FinanceViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:fvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:self animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 5){
                PictureViewController * pvc = [[PictureViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 6){
                TMDViewController * pvc = [[TMDViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 7){
                TiyuViewController * pvc = [[TiyuViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 8){
                gaoxiaoViewController * pvc = [[gaoxiaoViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 9){
                QicheViewController * pvc = [[QicheViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }
            else if (indexPath.row == 10){
                TansuoViewController * pvc = [[TansuoViewController alloc]init ];
                UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:pvc ];
                DrawerViewController *DrawerVC = [[DrawerViewController alloc] initWithLeftViewController:self centerViewController:nvc rightViewController:right];
                window.rootViewController = DrawerVC;
                nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self.navigationController presentViewController:nvc animated:YES completion:^{
                }];
            }


        }
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
