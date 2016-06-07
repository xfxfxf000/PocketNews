//
//  CommonCell.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *textIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;

@end
