//
//  TrHttpService.m
//  WJTR
//
//  Created by 邵 旭 on 15/5/12.
//  Copyright (c) 2015年 Senro Wong. All rights reserved.
//

#import "TrHttpService.h"
#import "AFNetworking.h"

@implementation TrHttpService

- (void)getWithUrlString:(NSString *)urlStr successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/plain",nil];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}


@end
