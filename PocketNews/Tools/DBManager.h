//
//  DBManager.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TopModel.h"

@interface DBManager : NSObject

+ (DBManager*) shareManager;
- (void)insertDataWithModal:(TopModel *)modal;
- (void)deleteDataWithArticleId:(NSString * )articleId;
- (void)deleteAllData;
- (void)updataDataWithModal:(TopModel *)modal;
- (NSArray * )fetchAllData;

@end
