//
//  FocusModal.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FocusModal : NSObject

@property (nonatomic ,copy)NSString * articleUrl;
@property (nonatomic,copy)NSString * thumbImgUrl;
@property (nonatomic ,copy)NSString * title;
@property (nonatomic, copy)NSString * articleType;
/*
 {
 Rows =     (
 {
 articleType = 11;
 articleUrl = "http://news.21cn.com/photo/client/2014/0716/08/27819504.shtml";
 thumbImgUrl = "http://img001.21cnimg.com/photos/album/20140716/o/0B49BBA22A2B0E0716AE8645A15403E4.jpg";
 title = "\U897f\U5b89\U6293400\U4f59\U4f20\U9500\U4eba\U5458 \U5927\U5b66\U751f\U5360\U56db\U6210";
 },
 */
@end
