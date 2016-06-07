//
//  ZCControl.h
//  ControlDemo
//
//  Created by 张诚 on 14/12/18.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface ZCControl : UIView
+(UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color;
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord;


- (void)setToolBarRect:(CGRect)rect backgroundImageName:(NSString *)name backgroundColor:(UIColor *)color;
- (void)addItemWithRect:(CGRect)rect image:(NSString *)name target:(id)target action:(SEL)action ;

+ (UIScrollView *)createScrollViewWithRect:(CGRect)rect ;

+ (UIImageView *)createImageViewWithRect:(CGRect)rect imageName:(NSString *)name;
+ (UIImageView *)createImageViewWithRect:(CGRect)rect imageWithURL:(NSString *)urlString placeholderImage:(NSString *)name;

+ (UILabel *)createLabelWithRect:(CGRect)rect text:(NSString *)text;
+ (UIButton *)createButtonWithRect:(CGRect)rect  title:(NSString *)title normalImage:(NSString *)normalName selectedIamge:(NSString *)selectedName target:(id)target action:(SEL)selector;

- (void)createCommentViewWithCommentCounts:(NSInteger )count imageName:(NSString *)name title:(NSString *)title comment:(NSString *)comment time:(NSString *)time;
@end
