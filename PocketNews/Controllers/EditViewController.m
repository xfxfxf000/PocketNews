//
//  EditViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "EditViewController.h"
#import "UMSocial.h"

@interface EditViewController ()<UITextViewDelegate>
{
    UITextView * _textView;
    UMSocialBar * socialBar;
}
@end

@implementation EditViewController

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
    [super viewDidLoad];
    [self uiconfig];
}
- (void)uiconfig{
    [self addTitleViewWithName:@"转发/回复"];
    [self addItemWithTitle:nil imageName:@"login_leftArrow" action:@selector(leftItemClick) location:YES];
    [self addItemWithTitle:nil imageName:@"channelManager_click" action:@selector(rightItemClick) location:NO];
    [self editComment];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height -64 -49)];
    if (_textString == nil) {
        _textView.text = @"说点什么吧...";
    }
    else{
        _textView.text = _textString;
    }
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.delegate = self;
    [self.view addSubview:_textView];
}
- (void)leftItemClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)rightItemClick
{
    [self.xukunDrawerViewController tapRightDrawerButton];
}
- (void)editComment
{

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
