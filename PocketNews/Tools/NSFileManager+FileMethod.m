//
//  NSFileManager+FileMethod.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "NSFileManager+FileMethod.h"

@implementation NSFileManager (FileMethod)

+ (BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time
{
    NSDictionary * dict = [[NSFileManager defaultManager]attributesOfItemAtPath:path error:nil];
    NSDate * createDate = [dict objectForKey:@"NSFileCreationDate"];
    NSDate * date = [NSDate date];
    NSTimeInterval currentTime = [date timeIntervalSinceDate:createDate];
    if (currentTime > time) {
        return YES;
    }
    else
        return NO;
}
@end
