//
//  ValueTransfer.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ValueTransfer : NSObject

+(ValueTransfer *)shareValue;

@property (nonatomic ,copy)NSString * value;
@property (nonatomic ,strong)NSArray * valueArray;

@end
