//
//  GirlsViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 谭强. All rights reserved.
//


#import "GirlsViewController.h"
#import "ScienceViewController.h"
#import "GirlCell.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "GirlPictureViewController.h"
#import "ArticalViewController.h"
#import "HttpRequest.h"
#import "TopModel.h"
#import "MJRefresh.h"
@interface GirlsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;

    NSInteger  _pageSize;
    
    UIImageView * bgImageView;
    
    NSMutableArray * _titleArray;
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
}
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation GirlsViewController
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
	_titleArray = [[NSMutableArray alloc]init ];
    _dataArray = [[NSMutableArray alloc]init ];
    _pageSize = 40;
	
    [self addTitleViewWithName:@"美女"];
    
   [self createRefresh];
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
    NSString *str = [NSString stringWithFormat:kGirlString,_pageSize];
    
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
    
        return 180 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"Cell";
    GirlCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GirlCell" owner:self options:nil]lastObject];
        
    }
    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor purpleColor];
    
        cell.girlImageView.frame = CGRectMake(5, 0, WIDTH, cell.frame.size.height-10);
        [cell.girlImageView setImageWithURL:[NSURL URLWithString:model.firstPicUrl] placeholderImage:[UIImage imageNamed:@"bglogo.png"]];
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    TopModel * model = [_dataArray objectAtIndex:indexPath.row];
//    ArticalViewController * avc = [[ArticalViewController alloc]init ];
//    avc.modal = model;
//    [self.navigationController pushViewController:avc animated:YES];
    GirlPictureViewController * avc = [[GirlPictureViewController alloc]init ];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:avc];
    
        TopModel * model = [_dataArray objectAtIndex:indexPath.row];
        avc.articleUrl = model.firstPicUrl;
            NSLog(@"model.articleUrl:%@",avc.articleUrl);
      [self presentViewController:nvc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
