//
//  ParentViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "ParentViewController.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

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
	
    self.view.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightmode) name:@"nightmode" object:nil];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"modeImage"] isEqualToString:@"daymode"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nhomeNavBarBg"] forBarMetrics:UIBarMetricsDefault];
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:nil] forBarMetrics:UIBarMetricsDefault] ;
    }
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"feedback_contact"] forBarMetrics:UIBarMetricsDefault] ;
}
- (void)nightmode
{
//    self.view.backgroundColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nhomeNavBarBg"] forBarMetrics:UIBarMetricsDefault];
}
- (void)addTitleViewWithName:(NSString *)name
{
    UILabel * label = [[UILabel alloc]init ];
    label.frame = CGRectMake(0, 0, 100, 30);
    label.text = name;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

- (void)addItemWithTitle:(NSString *)name imageName:(NSString *)imageName action:(SEL)selector location:(BOOL)isLeft
{
    UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:name forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
    }
    else
        self.navigationItem.rightBarButtonItem = item;
    
//    if (isLeft == YES) {
//        [self.navigationController.navigationBar addSubview:btn];
//    }
//    else{
//        btn.frame = CGRectMake(320 -7 -44 , 7, 30, 30);
//        [self.navigationController.navigationBar addSubview:btn];
//    }
    
}
- (UIBarButtonItem *)addItemWithTitle:(NSString *)name imageName:(NSString *)imageName target:(id)target action:(SEL)selector
{
    UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:name forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
    
}

- (NSArray *)createToolBarWithImageArray:(NSArray *)nameArray andTarget:(id)target Action:(SEL)selector
{
    self.navigationController.toolbarHidden = NO;
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 0  ; i < nameArray.count ; i ++ ) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc ]initWithImage:[[ UIImage imageNamed:[nameArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item.tag = i + 10;
        [array addObject:item];
        if (i != nameArray.count - 1) {
            UIBarButtonItem * space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:target action:selector];
            [array addObject:space];
        }
    }
    NSArray * arr = [NSArray arrayWithArray:array];
    return arr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
