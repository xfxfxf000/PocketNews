//
//  HttpRequest.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import <Foundation/Foundation.h>

//封装了客户端与服务端的交互逻辑
@interface HttpRequest : NSObject<NSURLConnectionDataDelegate>

//请求地址/接口
@property (nonatomic ,copy) NSString * requestString;
//用于存放请求下来的数据
@property (nonatomic ,retain) NSMutableData * downloadData;

//使用target-action（目标动作机制来实现）
//对象的泛型，可以接收任意的对象
@property (nonatomic ,assign) id target;
//可以赋成任意的方法
@property (nonatomic ,assign) SEL action;

//用于标记request是否是刷新的request
@property (assign ,nonatomic) BOOL isRefresh;

//为了让调用者使用方便，向外暴露一个类方法。
//外部通过此方法来指定下载地址，指定target和action
+ (HttpRequest *)requestWithUrlString:(NSString *)requestStr target:(id)target action:(SEL)action;
//适配器模式（软件设计模式的一种:在原有函数的基础之上，进行扩展，保留原有的函数，目的是为了达到调用原函数的类和新函数的类都能同时正常工作，既保留原有的功能又不影响新功能的扩展）
//实现刷新功能
+ (HttpRequest *)requestWithUrlString:(NSString *)requestStr target:(id)target action:(SEL)action isRefresh:(BOOL)isRefresh;
@end
