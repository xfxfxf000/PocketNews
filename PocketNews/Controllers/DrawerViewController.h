//
//  DrawerViewController.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController
@property(nonatomic,retain)UIViewController *LeftDrawerVC;

@property(nonatomic,retain)UIViewController *CenterDrawerVC;

@property(nonatomic,retain)UIViewController *RightDrawerVC;

//初始化方法

- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController rightViewController:(UIViewController *)rightViewController;

//点击左右按钮

- (void)tapLeftDrawerButton;

- (void)tapRightDrawerButton;

//关闭左抽屉,方便调用

- (void)closeLeftDrawer;

//关闭右抽屉,方便调用

- (void)closeRightDrawer;
@end
