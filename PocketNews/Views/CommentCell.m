//
//  CommentCell.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (IBAction)commentClick:(id)sender {
    [_target3 performSelector:_action3 withObject:self];
    NSLog(@"评论");
}

- (IBAction)praiseClick:(id)sender {
    [_target1 performSelector:_action1 withObject:self];
    NSLog(@"加");
}

- (IBAction)badClick:(id)sender {
    [_target2 performSelector:_action2 withObject:self];
    NSLog(@"减");
}
@end
