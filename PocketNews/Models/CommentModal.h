//
//  CommentModal.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CommentModal : NSObject

@property (nonatomic,copy)NSString * againstNum;
@property (nonatomic,copy)NSString * createTime;
@property (nonatomic,copy)NSString * reviewContent;
@property (nonatomic,copy)NSString * supportNum;
@property (nonatomic,copy)NSString * userNickName;
@property (nonatomic,copy)NSString * userIconUrl;

/*
 
 {
 "medalMap":{},
 "userMedalMap":{
 "0":[]
 },
 "pageTurn":{
 "currentPage":1,
 "end":10,
 "firstPage":1,
 "nextPage":2,
 "page":1,
 "pageCount":6,
 "pageSize":10,
 "prevPage":1,
 "rowCount":57,
 "start":0
 },
 "list":[
 {
 "againstNum":1,
 "childList":[],
 "contentId":27812969,
 "contentPic":null,
 "contentTime":null,
 "contentTitle":"湖南政协原副主席阳宝华被开除党籍 与他人通奸",
 "contentUrl":"http://news.21cn.com/domestic/jinriredian/a/2014/0715/11/27812969.shtml",
 "contentUserId":110425292,
 "createTime":"2014-07-15 11:39:03",
 "createTimeOfParent":null,
 "deviceType":"MOBILE",
 "hotDegree":10,
 "mobileUser":null,
 "operationId":9406,
 "pkIssueId":0,
 "realHotDegree":5,
 "reviewContent":"贪钱 通奸 腐败分子的两大通病。",
 "reviewContentOfParent":null,
 "reviewFrom":5,
 "reviewId":14495406,
 "reviewNum":0,
 "reviewParentId":0,
 "reviewPubMode":2,
 "reviewTarget":null,
 "reviewVisitor":null,
 "shareNum":0,
 "shieldFlag":1,
 "sumId":11491645,
 "supportNum":4,
 "topFlag":0,
 "userFrom":"mobile",
 "userIconUrl":"http://preview.cloud.189.cn/image/imageAction?param=59E5DB9C88DE5DEC39C22BAED0DDAACF3D3413FF544E5BE36FC903FDA7A8E113010E4A6E682E8935EDB93B364B5F7AD0EE60730ED03FA9E95E9546D8722D3460E4E0FE1602204319A4D9D00F60BB4740E14B4023",
 "userId":0,
 "userIp":"114.230.106.6",
 "userLocation":"江苏扬州市",
 "userNickName":"经济适用人",
 "userNickNameOfParent":null,
 "visitMode":11
 },
 */
@end
