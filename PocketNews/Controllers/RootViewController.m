//
//  RootViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "RootViewController.h"
#import "UIButton+WebCache.h"


@interface RootViewController ()
{
    UIButton * btn;
}
@end

@implementation RootViewController

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
    self.navigationController.toolbarHidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightmode) name:@"nightmode" object:nil];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"modeImage"] isEqualToString:@"daymode"]){
        [self addItemWithTitle:nil imageName:@"ntitle_leftButton" action:@selector(leftItemClick) location:YES];}
    else{
        [self addItemWithTitle:nil imageName:@"title_leftButton" action:@selector(leftItemClick) location:YES];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quitLogin) name:@"quitLogin" object:nil];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    if ([[defaults objectForKey:@"iconUrl"]hasPrefix:@"http"]) {
        [btn setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"iconUrl"]]];
        NSLog(@"iconUrl:%@",[defaults objectForKey:@"iconUrl"]);
    }
    else{
        [btn setImage:[UIImage imageNamed:[defaults objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
        NSLog(@"iconUrl:%@",[defaults objectForKey:@"iconUrl"]);
    }
    btn.layer.cornerRadius = 15;
    btn.clipsToBounds  = YES;
    [btn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;

    
    
//    CGFloat width = [DeviceManager currentScreenWidth];
//    CGFloat height = [DeviceManager currentScreenHeight];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}
- (void)loginSuccess
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [btn setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"iconUrl"]]];
}
- (void)quitLogin
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [btn setImage:[UIImage imageNamed:[defaults objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
}
- (void)leftItemClick{
   [self.xukunDrawerViewController tapLeftDrawerButton];
}
- (void)rightItemClick{
    [self.xukunDrawerViewController tapRightDrawerButton];
}
- (void)nightmode
{

}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
