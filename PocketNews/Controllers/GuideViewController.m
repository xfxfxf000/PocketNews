//
//  GuideViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView * scroll;
}
@end

@implementation GuideViewController

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
	[self uiconfig];
}
- (void)uiconfig
{
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT)];
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(320 * 4, HEIGHT);
    [self.view addSubview:scroll];
    
    for (int i = 0 ; i < 4; i ++ ) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 + i * WIDTH, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.png",i +1 ]];
        [scroll addSubview:imageView];
        for (int j = 0 ; j < 4 ; j ++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(108 + j * 28, 440, 20, 20);
            btn.tintColor = [UIColor clearColor];
            if (j == i) {
                [btn setImage:[[UIImage imageNamed:@"current_Page"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }
            else{
                [btn setImage:[UIImage imageNamed:@"page"] forState:UIControlStateNormal];
            }
            [imageView addSubview:btn];
        }
        if (i == 3) {
            UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backTo:)];
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            [imageView addGestureRecognizer:swipe];
        }
        [scroll addSubview:imageView];
    }
}
- (void)backTo:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"424242424``");
    if(swipe.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"424242424``");
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"contentOffset:%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >320 * 3) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
