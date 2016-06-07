//
//  SubscribeModal.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SubscribeModal : NSObject

@property (nonatomic,copy)NSString * articleType;
@property (nonatomic ,copy)NSString * listIds;
@property (nonatomic,copy)NSString * listType;
@property (nonatomic ,copy)NSString * thumbImgUrl;
@property (nonatomic ,copy)NSString * title;

@property (nonatomic ,assign)BOOL isSubscribe;
/*
 articleType = 0;
 listIds = 100178c;
 listType = 2;
 thumbImgUrl = "http://img003.21cnimg.com/photos/album/20130523/o/86FDA722CF7F6547792A97833B976533.png";
 title = "\U6295\U8bc9";
 */
@end
