//
//  CommentCell.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconUrl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commnetLabel;

@property (weak, nonatomic) IBOutlet UIButton *commnetBtn;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *badBtn;


@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *badLabel;
- (IBAction)commentClick:(id)sender;
- (IBAction)praiseClick:(id)sender;
- (IBAction)badClick:(id)sender;

@property (assign ,nonatomic) NSInteger index;
@property (assign ,nonatomic)id target1;
@property (assign ,nonatomic) SEL action1;
@property (assign ,nonatomic)id target2;
@property (assign ,nonatomic) SEL action2;
@property (assign ,nonatomic)id target3;
@property (assign ,nonatomic) SEL action3;


@end
