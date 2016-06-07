//
//  DBManager.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBManager
{
    FMDatabase * _database;
    NSLock * _lock;
}
static DBManager * manager = nil;
+ (DBManager*) shareManager
{
    @synchronized(self){
        if (manager == nil) {
            manager = [[DBManager alloc]init ];
        }
    }
    return manager;
}
-(id)init
{
    self = [super init ];
    if (self) {
        _lock = [[NSLock alloc]init ];
        NSString * path = [NSHomeDirectory() stringByAppendingString:@"/Documents/applications.db"];
        _database = [[FMDatabase alloc]initWithPath:path];
        BOOL isSuccessed = [_database open];
        if (isSuccessed) {
            NSString * createSql = @"create table if not exists application(id integer primary key autoincrement,title varchar(256),iconUrl varchar(256),publisher varchar(256),commentCount varchar(256),hot varchar(256),articleId varchar(256))";
            BOOL isCreateSuccessed = [_database executeUpdate:createSql];
            if (! isCreateSuccessed) {
                NSLog(@"create error:%@",_database.lastErrorMessage);
            }
        }
    }
    return self;
}
- (void)insertDataWithModal:(TopModel *)modal
{
    [_lock lock];
    NSString * insertSql = @"insert into application(title,iconUrl,publisher,commentCount,hot,articleId) values(?,?,?,?,?,?)";
    BOOL isSuccessed = [_database executeUpdate:insertSql,modal.title,modal.firstPicUrl,modal.sourceName,modal.reviewNum,modal.isHot,modal.articleId];
    if (! isSuccessed) {
        NSLog(@"insert error:%@",[_database lastErrorMessage]);
    }
    [_lock unlock];
}
- (void)deleteDataWithArticleId:(NSString * )articleId
{
    [_lock lock];
    NSString * deleteSql = @"delete from application where articleId = ?";
    BOOL isSuccessed = [_database executeUpdate:deleteSql,articleId];
    if (! isSuccessed) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
    NSLog(@"shanchuchenggong");
    [_lock unlock];
}
- (void)deleteAllData
{
    [_lock lock];
    NSString * deleteSql = @"delete from application ";
    BOOL isSuccessed = [_database executeUpdate:deleteSql];
    if (! isSuccessed) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
    NSLog(@"shanchuchenggong");
    [_lock unlock];
}
- (void)updataDataWithModal:(TopModel *)modal
{
    [_lock lock];
    NSString * updataSql = @"updata application set title= ?,iconUrl= ?,publisher =?,commentCount=?,hot = ?,articleId = ?";
    BOOL isSuccessed = [_database executeUpdate:updataSql,modal.title,modal.firstPicUrl,modal.sourceName,modal.reviewNum,modal.isHot,modal.articleId];
    if (! isSuccessed) {
        NSLog(@"updata error:%@",_database.lastErrorMessage);
    }
    [_lock unlock];
}
- (NSArray * )fetchAllData
{
    [_lock lock];
    NSString * selectSql = @"select * from application";
    FMResultSet * set = [_database executeQuery:selectSql];
    NSMutableArray * array = [[NSMutableArray alloc]init ];
    while ([set next]) {
        NSString * name = [set stringForColumn:@"title"];
        NSString * iconUrl = [set stringForColumn:@"iconUrl"];
        NSString * publisher = [set stringForColumn:@"publisher"];
        NSString * commentCount =[set stringForColumn:@"commentCount"];
        NSString * hot = [set stringForColumn:@"hot"];
        NSString * articleId = [set stringForColumn:@"articleId"];
        TopModel * modal = [[TopModel alloc]init ];
        modal.title = name;
        modal.firstPicUrl = iconUrl;
        modal.sourceName = publisher;
        modal.reviewNum = commentCount;
        modal.isHot = hot;
        modal.articleId = articleId;
        [array addObject:modal];
    }
    [_lock unlock];
    return array;
}
@end
