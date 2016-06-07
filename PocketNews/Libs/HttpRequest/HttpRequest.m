           //
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpRequestManager.h"
//字符串的类别，里面带有对字符串进行MD5加密的方法
#import "NSString+Hashing.h"
#import "NSFileManager+FileMethod.h"

@implementation HttpRequest
{
    NSURLConnection * _urlConnection;
}
#pragma mark - customMethods
-(id)init
{
    self = [super init];
    if (self) {
        //初始化downloadData
        _downloadData = [[NSMutableData alloc]init ];
    }
    return self;
}
+ (HttpRequest *)requestWithUrlString:(NSString *)requestStr target:(id)target action:(SEL)action
{
    return [HttpRequest requestWithUrlString:requestStr target:target action:action isRefresh:NO];
}
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (HttpRequest *)requestWithUrlString:(NSString *)requestStr target:(id)target action:(SEL)action isRefresh:(BOOL)isRefresh
{
    HttpRequest * request = [[HttpRequest alloc]init ];
    request.requestString = requestStr;
    request.target = target;
    request.action = action;
    //添加的
    request.isRefresh = isRefresh;
    //后期会加入数据的缓存机制
    //向服务器发起请求
    NSString * path = [HttpRequest filePathWithString:requestStr];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //指定路径下的文件存在，并且没有超时，则使用
    if ([fileManager fileExistsAtPath:path]&&[NSFileManager isTimeOutWithPath:path time:60*60]==NO && isRefresh == NO) {
        //使用缓存文件中的data
        //读取path中的data
        NSData * data = [NSData dataWithContentsOfFile:path];
        [request.downloadData setLength:0];
        [request.downloadData appendData:data];
        [request.target performSelector:request.action withObject:request];
        return request;
    }
    else{
        //发起请求
        [request startRequest];
    }
    //将request对象添加到requestManager中
    [[HttpRequestManager shareManager]setRequest:request forKey:requestStr];
    return request;
}

//通过请求地址，返回请求地址对应文件在程序沙盒中的路径
+(NSString *)filePathWithString:(NSString *)str
{
    // "程序文件夹根目录/Documents/downloadData文件"
    //NSHomeDirectory 获取程序文件夹根目录
    return [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",[str MD5Hash]];
}
- (void)startRequest{
    NSURL * url = [NSURL URLWithString:_requestString];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_downloadData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString * path = [HttpRequest filePathWithString:_requestString];
    [_downloadData writeToFile:path atomically:YES];
    if ([_target respondsToSelector:_action]) {

        [_target performSelector:_action withObject:self];
    }
    [[HttpRequestManager shareManager]removeRequestForKey:_requestString];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error localizedDescription]);
}
@end
