//
//  PictureViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "PictureViewController.h"
#import "ArticalViewController.h"
#import "HttpRequest.h"
#import "TopModel.h"
#import "PictureCell.h"
#import "UIImageView+WebCache.h"
#import "PicScanViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJRefresh.h"


@interface PictureViewController ()
{
    NSMutableArray * _titleArray;
    NSMutableArray * _dataArray;
    NSInteger  _pageSize;
    UIImageView * bgImageView;
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
}
@property(nonatomic,strong)NSMutableArray*dataArray;

@end

@implementation PictureViewController
- (void)dealloc
{
    [header free];
    [footer free];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define kTitleViewHeight 30
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createRefresh];
    _titleArray = [[NSMutableArray alloc]init ];
    _dataArray = [[NSMutableArray alloc]init ];
    _pageSize = 20;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightmode) name:@"modeImage" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(daymode) name:@"daymode" object:nil];
    [self addTitleViewWithName:@"读图"];
    [header beginRefreshing];
    
}
-(void)createRefresh{
    
    header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _pageSize=20;
        [self loadData];
        
    };
    footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _pageSize+=20;
        [self loadData];
    };
}

-(void)loadData
{
    NSString *str = [NSString stringWithFormat:kPictureString,_pageSize];
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    PictureCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PictureCell" owner:self options:nil]lastObject];
    }
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    [cell.picImageView setImageWithURL:[NSURL URLWithString:model.firstPicUrl]];
    cell.descLabel.text = model.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    PicScanViewController * avc = [[PicScanViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:avc];
    avc.articleId = model.articleId;
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end