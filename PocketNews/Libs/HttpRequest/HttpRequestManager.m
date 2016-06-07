//
//  HttpRequestManager.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "HttpRequestManager.h"

@implementation HttpRequestManager

{
    NSMutableDictionary * _dict;
}
static  HttpRequestManager * manager = nil;
+ (HttpRequestManager *)shareManager
{
    if (manager == nil) {
        manager = [[HttpRequestManager alloc]init ];
    }
    return manager;
}
-(id)init
{
    self = [super init ];
    if (self) {
        _dict = [[NSMutableDictionary alloc]init ];
    }
    return self;
}
//+ (void)setRequest:(id)request forKey:(NSString *)key
//{
//    [self setRequest:request forKey:key];
//}
//+ (void)removeRequestForKey:(NSString *)key
//{
//    [self removeRequestForKey:key];
//}

- (void)setRequest:(id)request forKey:(NSString *)key
{
    if (request != nil) {
        [_dict setObject:request forKey:key];
        
    }
}
- (void)removeRequestForKey:(NSString *)key{
    [_dict removeObjectForKey:key];
}
@end
