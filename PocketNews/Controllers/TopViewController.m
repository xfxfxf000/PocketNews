//
//  TopViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "TopViewController.h"
#import "ArticalViewController.h"
#import "HttpRequest.h"
#import "TopModel.h"
#import "CommonCell.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJRefresh.h"
#import "ZCControl.h"
#import "SYAppStart.h"


@interface TopViewController ()
{
    BOOL _isFirstWillAppear;
    BOOL _isFirstDidAppear;
    
    UIImageView * bgImageView;
    NSTimer * timer;
    
    NSMutableArray * _dataArray;
    NSMutableArray * _focusArray;
    
    
    NSInteger  _pageSize;
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
}
@property(nonatomic,strong)NSMutableArray*dataArray;


@end

@implementation TopViewController
- (void)dealloc
{
    [header free];
    [footer free];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.noShowAppStart) {
        return;
    }
    
    if (!_isFirstWillAppear) {
        _isFirstWillAppear = YES;
        [SYAppStart show];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.noShowAppStart) {
        return;
    }
    if (!_isFirstDidAppear) {
        _isFirstDidAppear = YES;
        [SYAppStart hide:YES];
    }
}

#define kTitleViewHeight 30
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createRefresh];
    _focusArray = [[NSMutableArray alloc]init ];
    _dataArray = [[NSMutableArray alloc]init ];
    _pageSize = 20;
	
    [self addTitleViewWithName:@"头条"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightmode) name:@"modeImage" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(daymode) name:@"daymode" object:nil];
    
    [header beginRefreshing];
    
}
-(void)createRefresh{
    __weak typeof(self) weakSelf = self;
    header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _pageSize=20;
        [weakSelf loadNewData];
        
    };
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _pageSize+=20;
        [weakSelf loadData];
    };
}

-(void)loadData
{
    NSString *str = [NSString stringWithFormat:kTopString,_pageSize];
    
    HttpRequestBlock *block =[[HttpRequestBlock alloc]initWithUrlPath:str Block:^(BOOL isSucceed, HttpRequestBlock *http){
        
        
        if (isSucceed) {
            
            
            //NSDictionary * mdict = (NSDictionary *)http;
            NSArray * array = http.dataDic[@"Rows"];
            NSMutableArray *array1=[NSMutableArray arrayWithCapacity:0];
            for (int i= _pageSize-20; i<=array.count-3; i++) {
                [array1 addObject:array[i]];
            }
            
            if (_pageSize==20) {
                self.dataArray=[NSMutableArray arrayWithCapacity:0];
            }
            for (NSDictionary *dict in array1) {
                TopModel*model=[[TopModel alloc]init];
                //[model setValuesForKeysWithDictionary:dict];
                model.articleId = [dict objectForKey:@"articleId"];
                model.title = [dict objectForKey:@"title"];
                model.firstPicUrl = [dict objectForKey:@"firstPicUrl"];
                model.sourceName = [dict objectForKey:@"sourceName"];
                model.reviewNum = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"reviewNum"]integerValue]];
                model.isHot = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"isHot"]integerValue]];
                [self.dataArray addObject:model];
            }
            [_tableView reloadData];
            if (_pageSize==20) {
                [header endRefreshing];
            }else{
                [footer endRefreshing];
            }
        }
        
    }];
}

- (void)loadNewData {
    NSString *urlStr = [NSString stringWithFormat:kTopString,_pageSize];
    TrHttpService *service = [[TrHttpService alloc] init];
    [service getWithUrlString:urlStr successBlock:^(id backJson) {
        NSArray * array = backJson[@"Rows"];
        NSMutableArray *array1=[NSMutableArray arrayWithCapacity:0];
        for (int i= _pageSize-20; i<=array.count-3; i++) {
            [array1 addObject:array[i]];
        }
        
        if (_pageSize==20) {
            self.dataArray=[NSMutableArray arrayWithCapacity:0];
        }
        for (NSDictionary *dict in array1) {
            TopModel*model=[[TopModel alloc]init];
            //[model setValuesForKeysWithDictionary:dict];
            model.articleId = [dict objectForKey:@"articleId"];
            model.title = [dict objectForKey:@"title"];
            model.firstPicUrl = [dict objectForKey:@"firstPicUrl"];
            model.sourceName = [dict objectForKey:@"sourceName"];
            model.reviewNum = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"reviewNum"]integerValue]];
            model.isHot = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"isHot"]integerValue]];
            [self.dataArray addObject:model];
        }
        [_tableView reloadData];
        if (_pageSize==20) {
            [header endRefreshing];
        }else{
            [footer endRefreshing];
        }
    } failureBlock:^(NSError *errorM) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    CommonCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonCell" owner:self options:nil]lastObject];
    }
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    if (model.firstPicUrl.length == 0) {
        cell.titleLabel.frame = CGRectMake(10, 0, 300, 50);
        cell.infoLabel.frame = CGRectMake(10, 60, 300, 20);
        cell.textIamgeView.hidden = YES;
    }
    else{
        cell.titleLabel.frame = CGRectMake(100, 0, 210, 50);
        cell.infoLabel.frame = CGRectMake(100, 60, 210, 20);
        cell.textIamgeView.hidden = NO;
        [cell.textIamgeView setImageWithURL:[NSURL URLWithString:model.firstPicUrl] placeholderImage:[UIImage imageNamed:@"bglogo.png"]];
        if (model.isHot.integerValue == 1) {
            cell.hotImageView.image = [UIImage imageNamed:@"isHot"];
        }
    }
    cell.titleLabel.text = model.title;
    cell.infoLabel.text = model.sourceName;
    cell.commentLabel.text = [NSString stringWithFormat:@"%d评论",model.reviewNum.intValue];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"modeImage"] isEqualToString:@"daymode"]) {
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.titleLabel.backgroundColor = [UIColor darkGrayColor];
        cell.infoLabel.backgroundColor = [UIColor darkGrayColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
        cell.infoLabel.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    ArticalViewController * avc = [[ArticalViewController alloc]init ];
    avc.modal = model;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)nightmode
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
