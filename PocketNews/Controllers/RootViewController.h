//
//  RootViewController.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "ParentViewController.h"
#import "TrHttpService.h"


@interface RootViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end
