//
//  TopModel.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface TopModel : NSObject
/*
 {
 "articleId" : 27779464,
 "articleType" : 11,
 "articleUrl" : "http://news.21cn.com/hot/cn/client/2014/0710/10/27779464.shtml",
 "columnId" : 0,
 "displayType" : 1,
 "firstPicUrl" : "http://img001.21cnimg.com/photos/album/20140710/o/A26E6DBDA54DDBB86D4374A85B2EB564.jpg",
 "isHot" : 0,
 "isRecommend" : 0,
 "isSpecial" : 0,
 "originalHeight" : 0,
 "originalWidth" : 0,
 "publishTime" : "2014-07-10 10:53:54",
 "regionId" : 954,
 "reviewNum" : 68,
 "sourceId" : 7595,
 "sourceName" : "新华网",
 "summary" : "资料图片新华网北京7月10日电国务院新闻办公室10日发表的《中国的对外援助(2014)》白皮书说，2010年至2012年",
 "thumbImgUrl" : "http://img001.21cnimg.com/photos/album/20140710/o/A26E6DBDA54DDBB86D4374A85B2EB564.jpg",
 "thumbImgUrlList" : [],
 "title" : "中国3年向121国家提供援助 免14亿债务",
 "topTime" : "2014-07-10 23:42:00",
 "weight" : 20
 },
 "Total" : 20,
 "currentPage" : 1,
 "result" : "0"
 */
@property (nonatomic,copy) NSString * isHot;
@property (nonatomic,copy)NSString * articleUrl;
@property (nonatomic,copy) NSString * firstPicUrl;
@property (nonatomic,copy)NSString * sourceName;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy) NSString * reviewNum;
@property (nonatomic,copy)NSString * articleId;
@property (nonatomic,assign)BOOL isMark;
@property (nonatomic) NSNumber *isSpecial;

//@property (nonatomic,copy) NSString * isHot;
//@property (nonatomic,copy)NSString * articleUrl;

@end
