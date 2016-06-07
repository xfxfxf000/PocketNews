//
//  ZCControl.m
//  ControlDemo
//
//  Created by 张诚 on 14/12/18.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "ZCControl.h"
#import "UIImageView+WebCache.h"

@interface ZCControl ()
{
    UIImageView * imageView;
}

@end

@implementation ZCControl
+(UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    if (color!=nil) {
        view.backgroundColor=color;
    }
    return view;
}
+ (UIScrollView *)createScrollViewWithRect:(CGRect)rect {
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:rect];
    return scroll;
}
+ (UIImageView *)createImageViewWithRect:(CGRect)rect imageName:(NSString *)name{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.image = [UIImage imageNamed:name];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}
+ (UIImageView *)createImageViewWithRect:(CGRect)rect imageWithURL:(NSString *)urlString placeholderImage:(NSString *)name{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect];
    [imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:name]];
    imageView.userInteractionEnabled = YES;
    return imageView;
}
+ (UILabel *)createLabelWithRect:(CGRect)rect text:(NSString *)text{
    UILabel * lab = [[UILabel alloc]initWithFrame:rect];
    lab.text = text;
    lab.textAlignment = NSTextAlignmentLeft;
    return lab;
}
+ (UIButton *)createButtonWithRect:(CGRect)rect  title:(NSString *)title normalImage:(NSString *)normalName selectedIamge:(NSString *)selectedName target:(id)target action:(SEL)selector
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed: normalName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    return btn;
}
- (void)createCommentViewWithCommentCounts:(NSInteger )count imageName:(NSString *)name title:(NSString *)title comment:(NSString *)comment time:(NSString *)time
{
    UIImageView * titleImageView  = [[UIImageView alloc ]initWithFrame: CGRectMake(10, 10, 40, 40)];
    [titleImageView setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"login_tip"]];
    [self addSubview:titleImageView];
    
    
    [self addSubview: [ZCControl createLabelWithRect:CGRectMake(60, 0, 140, 20) text:title]];
    UILabel *timeLab = [ZCControl createLabelWithRect:CGRectMake(190, 0, 130, 20) text:time];
    UILabel *commentLab = [ZCControl createLabelWithRect:CGRectMake(60, 20, 250, 50) text:comment];
    commentLab.numberOfLines = 2;
    timeLab.font = [UIFont systemFontOfSize:13];
    [self addSubview: timeLab];
    [self addSubview:commentLab];
    
}
- (void)setToolBarRect:(CGRect)rect backgroundImageName:(NSString *)name backgroundColor:(UIColor *)color{
    imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.backgroundColor = color;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:name];
    [self addSubview:imageView];
}
- (void)addItemWithRect:(CGRect)rect image:(NSString *)name target:(id)target action:(SEL)action {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
}
#define kBtnFont  18
#define kBtnWidth  50
#define kBtnHeigth 30
#define kSpace  10

- (void)addTitles:(NSArray *)array
{
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 290, 30)];
    scroll.contentSize = CGSizeMake(array.count * (kBtnWidth + kSpace) + kSpace, 30);
    scroll.userInteractionEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        NSString * s = [array objectAtIndex:i];
        //        CGFloat width = [s sizeWithFont:[UIFont systemFontOfSize: kBtnFont]].width;
        btn.frame = CGRectMake(kBtnWidth * i, 0, kBtnWidth, kBtnHeigth);
        //        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:s forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:btn];
        if (i == 0 ) {
            CGRect frame = btn.frame;
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x + kSpace, frame.origin.y + 28, frame.size.width - 2* kSpace, frame.size.height)];
            label.backgroundColor = [UIColor blueColor];
            label.tag = 10;
            [scroll addSubview:label];
        }
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(290, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"箭头向下"] forState:UIControlStateNormal];
    [self addSubview:button];
    
}
- (void )btnClick:(UIButton *)btn
{
    CATransition * animation = [[CATransition alloc]init ];
    animation.duration = 2.0f;
    [[[self.subviews objectAtIndex:0]layer] addAnimation:animation forKey:@"animation"];
    
    
    CGRect frame = btn.frame;
    UILabel * label = (UILabel *)[[self.subviews objectAtIndex:0] viewWithTag:10];
    label.frame = CGRectMake(frame.origin.x + kSpace, frame.origin.y + 28, frame.size.width - 2* kSpace, frame.size.height);
    
    
}


+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    if (placeholder) {
        textField.placeholder=placeholder;
    }
    if (imageName) {
        textField.background=[UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView=leftView;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView=rightView;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry=YES;
    }
    return textField;
}
@end







