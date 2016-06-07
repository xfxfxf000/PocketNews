//
//  TrHttpService.h
//  WJTR
//
//  Created by 邵 旭 on 15/5/12.
//  Copyright (c) 2015年 Senro Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id backJson);
typedef void(^FailureBlock)(NSError *errorM);

@interface TrHttpService : NSObject

- (void)getWithUrlString:(NSString *)urlStr successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
