//
//  ValueTransfer.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "ValueTransfer.h"

@implementation ValueTransfer

static  ValueTransfer * transfer = nil;
+(ValueTransfer *)shareValue
{
    if (transfer == nil) {
        transfer = [[ValueTransfer alloc]init ];
    }
    return transfer;
}
@end
