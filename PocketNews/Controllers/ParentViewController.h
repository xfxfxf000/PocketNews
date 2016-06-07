//
//  ParentViewController.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController

@property (nonatomic ,assign)CGFloat wordSize;

- (void)addTitleViewWithName:(NSString *)name;
- (void)addItemWithTitle:(NSString *)name imageName:(NSString *)imageName action:(SEL)selector location:(BOOL)isLeft;
- (UIBarButtonItem *)addItemWithTitle:(NSString *)name imageName:(NSString *)imageName target:(id)target action:(SEL)selector;

- (NSArray *)createToolBarWithImageArray:(NSArray *)nameArray andTarget:(id)target Action:(SEL)selector;
@end
