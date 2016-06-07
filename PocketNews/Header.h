//
//  Header.h
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//
#define kRefreshData @"refresh"
#define kLoadMoreData @"laadMore"
//53b75cf756240b32fb000dcd
#define kWordSize 18
#define kUMKeyString @"57258a7be0f55a0b510031d0"
#define kGaodeMap @"9cd6ddcac91a2988cc9d42cfc59acf78"

//滚动焦点
#define jiaodian @"http://www.21cn.com/api/client/v2/getFocusList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&"
//头条
#define kTopString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=954r,1003r"
//娱乐
#define kEntertainmentString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=711r,846r,1235r"
//财经
#define caijing @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=1630r,709r,844r"
//科技
#define kScienceString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=1631r"
//星座
#define Kxinzuo @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=101530c"
//搞笑
#define Kgaoxiao @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=1633r"
//投诉
#define Ktousu @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=20&hasImg=%d&articleType=11&listIds=100178c"
//女性
#define Knvxing @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=20&hasImg=%d&articleType=0&listIds=100455c,100445c,100448c"
//体育
#define Ktiyu @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=100251c,100230c,100195c,100260c"
//探索
#define Ktansuo @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=100076c"
//汽车
#define Kqiche @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=d9212df45e15ba6784417320a8e215f5&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=1635r"

//本地 接经纬度，省，市
#define kNativeString @"http://www.21cn.com/api/client/v2/getLocalNewsList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&province=%@&pageSize=%d&hasImg=0&longitude=%f&latitude=%f&articleType=11&city=%@"
//#define kNativeString @"http://www.21cn.com/api/client/v2/getLocalNewsList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&province=%E5%8C%97%E4%BA%AC%E5%B8%82&pageSize=20&hasImg=0&longitude=116.376131&latitude=40.043442&articleType=11&city=%E5%8C%97%E4%BA%AC%E5%B8%82"
//读图
#define kPictureString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=0&listIds=100905c,100028c,100924c,100916c,101559c,101083c"
//图片公共接口
#define kPictureDetail @"http://www.21cn.com/api/client/v2/getArticleContent.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&display=album&articleId=%@"
//文章公共端口 接articleId
#define kArticleString @"http://www.21cn.com/api/client/v2/getShareContent.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&articleId=%@"
//文章细节公共端口 接contentUrl
#define kArticleDetailString @"http://review.21cn.com/review/list.do?jsoncallback=jsonp_callback2&contentUrl=%@"
//评论 接contentUrl
#define kCommentString @"http://review.21cn.com/review/list.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=10&order=hot&pageNo=1&contentUrl=%@"

//添加订阅
#define kSubcribeString @"http://www.21cn.com/api/client/v2/getSubscribeAllList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&"
//订阅之后的栏目公共接口: articleType   listIds
#define kSubArticleString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&articleType=%@&listIds=%@"


//美女
#define kGirlString @"http://www.21cn.com/api/client/v2/getClientArticleList.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&accessToken=&pageSize=%d&hasImg=0&removeRepeat=0&listIds=101669c&getReviewCount=0&getSourceName=0&articleType=12"
#define kUpdateString @"http://k.21cn.com//cloundapp/api/appVersion/getAppLastVersion.do?userSerialNumber=85d3bbb95d03920e3c53d3801781c806&appId=5&appVersionCode=23&channelName=anzhi"

