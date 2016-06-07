//
//  HttpRequestManager.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestManager : NSObject

+ (HttpRequestManager *)shareManager;

//+ (void)setRequest:(id)request forKey:(NSString *)key;
//+ (void)removeRequestForKey:(NSString *)key;

- (void)setRequest:(id)request forKey:(NSString *)key;
- (void)removeRequestForKey:(NSString *)key;

@end
