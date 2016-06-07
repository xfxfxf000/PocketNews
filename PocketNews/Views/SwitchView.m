//
//  SwitchView.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "SwitchView.h"


@interface SwitchView ()
{
    UIButton * _btn;
    UILabel * _textLabel;
}
@end
@implementation SwitchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self uiconfig];
    }
    return self;
}
- (void)setSwitchViewWithTitle:(NSString *)title;
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(300, 99999) lineBreakMode:NSLineBreakByWordWrapping];
    _textLabel = [ZCControl createLabelWithRect:CGRectMake(40, 20, size.width, 30) text:title];
    [_btn addSubview:_textLabel];
}
- (void)uiconfig
{
    _btn = [ZCControl createButtonWithRect:CGRectMake(10, 0, 300, 70) title:nil normalImage:@"main_list_press" selectedIamge:nil target:self action:@selector(btnClick)];
    _btn.selected = NO;
    [self addSubview:_btn];
    
    UISwitch * s = [[UISwitch alloc ]initWithFrame:CGRectMake(240, 20, 50, 30)];
    [s addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    s.on = NO;
    s.onTintColor = [UIColor redColor];
    [self addSubview:s];
}
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}
- (void)btnClick
{
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}
- (void)switchClick:(UISwitch *)s
{
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
