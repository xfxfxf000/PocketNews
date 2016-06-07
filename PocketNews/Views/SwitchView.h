//
//  SwitchView.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SwitchView : UIView

@property (nonatomic,assign) id target;
@property (nonatomic ,assign) SEL action;
@property (nonatomic, copy) NSString * text;

- (void)setSwitchViewWithTitle:(NSString *)title;
@end
