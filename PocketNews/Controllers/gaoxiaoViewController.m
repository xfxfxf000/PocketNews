//
//  gaoxiaoViewController.m
//  头版的
//
//  Created by qianfeng on 15-1-31.
//  Copyright (c) 2015年 谭强. All rights reserved.
//

#import "gaoxiaoViewController.h"
#import "ArticalViewController.h"
#import "HttpRequest.h"
#import "TopModel.h"
#import "CommonCell.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJRefresh.h"
@interface gaoxiaoViewController ()
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

@implementation gaoxiaoViewController
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
    [self addTitleViewWithName:@"搞笑"];
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
    NSString *str = [NSString stringWithFormat:Kgaoxiao,_pageSize];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
