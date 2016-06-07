//
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "ParentViewController.h"
#import "TopModel.h"

@interface ArticalViewController : ParentViewController

@property (nonatomic, strong) TopModel * modal;

@property (nonatomic ,copy)NSString * articalUrl;
@property (nonatomic ,copy)NSString * titleText;
@property (nonatomic ,copy)NSString * infoText;
@property (nonatomic ,copy)NSString * articleId;
@property (nonatomic ,copy)NSString * timeText;
@property (nonatomic ,copy)NSString * netText;
@property (nonatomic ,copy)NSString * sourceName;

@end
